DROP TABLE IF EXISTS `merchant_product_composites`;
DROP TABLE IF EXISTS `merchant_products`;

--
-- Table structure for table 'merchant_products'
--
CREATE TABLE IF NOT EXISTS `merchant_products`
(
 `id`                  CHAR(36) NOT NULL,
 `merchant_id`         CHAR(36) NOT NULL,
 `parent_id`           CHAR(36),
 `name`                VARCHAR(255) NOT NULL,
 `handle`              VARCHAR(255) NOT NULL,
 `product_type`        JSON,
 `product_brand`       JSON,
 `product_uom`         JSON,
 `resource`            JSON,
 `supplier`            JSON,
 `supplier_code`       VARCHAR(255),
 `supply_price`        DECIMAL(15, 5),
 `markup`              DECIMAL(15, 5),
 `price`               DECIMAL(15, 5) DEFAULT 0.0,
 `price_incl_tax`      DECIMAL(15, 5) DEFAULT 0.0,
 `tax`                 DECIMAL(15, 5) DEFAULT 0.0,
 `tax_rate`            JSON,
 `description`         TEXT,
 `image_url`           VARCHAR(255),
 `image_urls`          TEXT,
 `has_variants`        ENUM('Y', 'N') NOT NULL DEFAULT 'N',
 `variant_options`     JSON,
 `sku`                 VARCHAR(255),
 `stock_type`          ENUM('STANDARD', 'COMPOSITE') NOT NULL DEFAULT 'STANDARD',
 `track_inventory`     ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
 `is_active`           ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
 `is_deleted`          ENUM('Y', 'N') NOT NULL DEFAULT 'N',
 `created`             DATETIME,
 `deleted`             DATETIME,
 `updated`             DATETIME,

 PRIMARY KEY (`id`),

 FOREIGN KEY (`parent_id`) REFERENCES `merchant_products` (`id`)
   ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = `InnoDB` DEFAULT CHARACTER SET = `utf8`;

--
-- Table structure for table 'merchant_product_composites'
--
CREATE TABLE IF NOT EXISTS `merchant_product_composites`
(
 `id`                  BIGINT NOT NULL AUTO_INCREMENT,
 `merchant_id`         CHAR(36) NOT NULL,
 `parent_id`           CHAR(36) NOT NULL,
 `product_id`          CHAR(36) NOT NULL,
 `quantity`            REAL NOT NULL DEFAULT 1.0,
 `is_active`           ENUM('Y', 'N') NOT NULL DEFAULT 'Y',
 `is_deleted`          ENUM('Y', 'N') NOT NULL DEFAULT 'N',
 `created`             DATETIME,
 `deleted`             DATETIME,
 `updated`             DATETIME,

 PRIMARY KEY (`id`),

 FOREIGN KEY (`parent_id`) REFERENCES `merchant_products` (`id`)
   ON DELETE CASCADE ON UPDATE CASCADE,

 FOREIGN KEY (`product_id`) REFERENCES `merchant_products` (`id`)
   ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = `InnoDB` DEFAULT CHARACTER SET = `utf8`;