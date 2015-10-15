--Update from 3.2.x to 3.20.x
ALTER TABLE `items`
	DROP INDEX `itembarcodeidx`;

ALTER TABLE items ADD INDEX `itembarcodeidx` (`barcode`);
