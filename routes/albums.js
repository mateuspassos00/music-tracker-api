import express from "express";
import { PrismaClient } from "@prisma/client";

const router = express.Router();
const prisma = new PrismaClient();

// GET /api/albums -- returns all albums in collection, sorted by creation date desc
router.get("/", async (req, res) => {
  const albums = await prisma.album.findMany({
    orderBy: { createdAt: "desc" },
  });
  res.json(albums);
});

// POST /api/albums -- adds a new album to the collection, expects { mbid, title, artist, year, coverUrl } in body
router.post("/", async (req, res) => {
  const { mbid, title, artist, year, coverUrl } = req.body;
  const existing = await prisma.album.findUnique({ where: { mbid } });
  if (existing) {
    return res.status(409).json({ error: "Album already in collection" });
  }
  const album = await prisma.album.create({
    data: { mbid, title, artist, year, coverUrl },
  });
  res.status(201).json(album);
});

// DELETE /api/albums/:id -- removes an album from the collection by its database ID
router.delete("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await prisma.album.delete({ where: { id } });
  res.status(204).send();
});

export default router;