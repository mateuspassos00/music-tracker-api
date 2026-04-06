/*
  Warnings:

  - You are about to alter the column `createdAt` on the `Album` table. The data in that column could be lost. The data in that column will be cast from `Unsupported("timestamp(3)")` to `DateTime`.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Album" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "mbid" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "artist" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    "coverUrl" TEXT NOT NULL,
    "rating" INTEGER,
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Album" ("artist", "coverUrl", "createdAt", "id", "mbid", "notes", "rating", "title", "year") SELECT "artist", "coverUrl", "createdAt", "id", "mbid", "notes", "rating", "title", "year" FROM "Album";
DROP TABLE "Album";
ALTER TABLE "new_Album" RENAME TO "Album";
CREATE UNIQUE INDEX "Album_mbid_key" ON "Album"("mbid");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
