<?php

function rrmdir($src, $removeRoot = false) {
    $dir = opendir($src);
    while(false !== ( $file = readdir($dir)) ) {
        if (( $file != '.' ) && ( $file != '..' )) {
            $full = $src . '/' . $file;
            if ( is_dir($full) ) {
                rrmdir($full, true);
            }
            else {
                unlink($full);
            }
        }
    }
    closedir($dir);
    if ($removeRoot)
      rmdir($src);
}
function recurseCopy($src, $dst) {
    $dir = opendir($src);
    mkdir($dst);
    while(false !== ( $file = readdir($dir)) ) {
        if (( $file != '.' ) && ( $file != '..' )) {
            if ( is_dir($src . '/' . $file) ) {
                recurseCopy($src . '/' . $file, $dst . '/' . $file);
            } else {
                copy($src . '/' . $file,$dst . '/' . $file);
            }
        }
    }
    closedir($dir);
}

function zipDirectory($directory, $destZip) {
  // Get real path for our folder
  $rootPath = realpath($directory);

  // Initialize archive object
  $zip = new ZipArchive();
  $zip->open($destZip, ZipArchive::CREATE | ZipArchive::OVERWRITE);

  // Create recursive directory iterator
  /** @var SplFileInfo[] $files */
  $files = new RecursiveIteratorIterator(
      new RecursiveDirectoryIterator($rootPath),
      RecursiveIteratorIterator::LEAVES_ONLY
  );

  foreach ($files as $name => $file)
  {
      // Skip directories (they would be added automatically)
      if (!$file->isDir())
      {
          // Get real and relative path for current file
          $filePath = $file->getRealPath();
          $relativePath = substr($filePath, strlen($rootPath) + 1);
          $relativePath = basename($directory) . "/" . $relativePath;

          // Add current file to archive
          $zip->addFile($filePath, $relativePath);
      }
  }

  // Zip archive will be created only after closing object
  $zip->close();
}



$projectDir = getcwd();
$infoFile = $projectDir . "\src\info.json";
$buildDir = $projectDir . "\build";

$factorio_mods_folder = getenv("APPDATA") . "\Factorio\mods";

$contents = file_get_contents($infoFile);
$json_data = json_decode($contents);

$name = $json_data->name;
$version = $json_data->version;

$sourceDir = $projectDir . "\src";
$destDir = $buildDir . "\\" . $name . "_" . $version;
$zipName = $name . "_" . $version . ".zip";
$zipPath = $destDir . ".zip";
$modZipPath = $factorio_mods_folder . "\\" . $zipName;

$modsDirectory = opendir($factorio_mods_folder);
while($entryName = readdir($modsDirectory)) {
	if (strpos($entryName, $name) !== false) {
    unlink($factorio_mods_folder . "\\" . $entryName);
  }
}
closedir($modsDirectory);
rrmdir($buildDir);
recurseCopy($sourceDir, $destDir);
zipDirectory($destDir, $zipPath);
rrmdir($destDir, true);
copy($zipPath, $modZipPath);
