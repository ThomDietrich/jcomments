CREATE TABLE "#__jcomments" (
"id" serial NOT NULL,
"parent" bigint DEFAULT 0 NOT NULL,
"thread_id" bigint DEFAULT 0 NOT NULL,
"path" VARCHAR(255) DEFAULT '' NOT NULL,
"level" smallint DEFAULT 0 NOT NULL,
"object_id" bigint DEFAULT 0 NOT NULL,
"object_group" VARCHAR(255) DEFAULT '' NOT NULL,
"object_params" TEXT DEFAULT '' NOT NULL,
"lang" VARCHAR(255) DEFAULT '' NOT NULL,
"userid" bigint DEFAULT 0 NOT NULL,
"name"VARCHAR(255)  DEFAULT '' NOT NULL,
"username"VARCHAR(255) DEFAULT '' NOT NULL,
"email" VARCHAR(255) DEFAULT '' NOT NULL,
"homepage" VARCHAR(255) DEFAULT '' NOT NULL,
"title" VARCHAR(255) DEFAULT '' NOT NULL,
"comment" TEXT DEFAULT '' NOT NULL,
"ip" VARCHAR(39) DEFAULT '' NOT NULL,
"date" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"isgood" SMALLINT DEFAULT 0 NOT NULL,
"ispoor" SMALLINT DEFAULT 0 NOT NULL,
"published" smallint DEFAULT 0 NOT NULL,
"deleted" smallint DEFAULT 0 NOT NULL,
"subscribe" smallint DEFAULT 0 NOT NULL,
"source" VARCHAR(255) DEFAULT '' NOT NULL,
"source_id" bigint DEFAULT 0 NOT NULL,
"checked_out" bigint DEFAULT 0 NOT NULL,
"checked_out_time" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"editor" VARCHAR(50) DEFAULT NULL,
PRIMARY KEY  ("id")
);
CREATE INDEX "#__jcomments_idx_userid" ON "#__jcomments" ("userid");
CREATE INDEX "#__jcomments_idx_source" ON "#__jcomments" ("source");
CREATE INDEX "#__jcomments_idx_email" ON "#__jcomments" ("email");
CREATE INDEX "#__jcomments_idx_lang" ON "#__jcomments" ("lang");
CREATE INDEX "#__jcomments_idx_subscribe" ON "#__jcomments" ("subscribe");
CREATE INDEX "#__jcomments_idx_checkout" ON "#__jcomments" ("checked_out");
CREATE INDEX "#__jcomments_idx_object" ON "#__jcomments" ("object_id", "object_group", "published", "date");
CREATE INDEX "#__jcomments_idx_path" ON "#__jcomments" ("path", "level");
CREATE INDEX "#__jcomments_idx_thread" ON "#__jcomments" ("thread_id");


CREATE TABLE "#__jcomments_settings" (
"component" VARCHAR(50) NOT NULL DEFAULT '',
"lang" VARCHAR(20) NOT NULL DEFAULT '',
"name" VARCHAR(50) NOT NULL DEFAULT '',
"value" TEXT NOT NULL DEFAULT '',
PRIMARY KEY  ("component", "lang", "name")
);

CREATE TABLE "#__jcomments_votes" (
"id" serial NOT NULL,
"commentid" bigint DEFAULT 0 NOT NULL,
"userid" bigint DEFAULT 0 NOT NULL,
"ip" VARCHAR(39) DEFAULT '' NOT NULL,
"date" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"value" smallint NOT NULL,
PRIMARY KEY  ("id")
);
CREATE INDEX "#__jcomments_votes_idx_comment" ON "#__jcomments_votes" ("commentid", "userid");
CREATE INDEX "#__jcomments_votes_idx_user" ON "#__jcomments_votes" ("userid", "date");

CREATE TABLE "#__jcomments_subscriptions" (
"id" serial NOT NULL,
"object_id" bigint DEFAULT 0 NOT NULL,
"object_group" VARCHAR(255) DEFAULT '' NOT NULL,
"lang" VARCHAR(255) DEFAULT '' NOT NULL,
"userid" bigint DEFAULT 0 NOT NULL,
"name"VARCHAR(255) DEFAULT '' NOT NULL,
"email" VARCHAR(255) DEFAULT '' NOT NULL,
"hash" VARCHAR(255) DEFAULT '' NOT NULL,
"published" smallint DEFAULT 0 NOT NULL,
"source" VARCHAR(255) DEFAULT '' NOT NULL,
"checked_out" bigint DEFAULT 0 NOT NULL,
"checked_out_time" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
PRIMARY KEY ("id")
);
CREATE INDEX "#__jcomments_subscriptions_idx_object" ON "#__jcomments_subscriptions" ("object_id", "object_group");
CREATE INDEX "#__jcomments_subscriptions_idx_lang" ON "#__jcomments_subscriptions" ("lang");
CREATE INDEX "#__jcomments_subscriptions_idx_source" ON "#__jcomments_subscriptions" ("source");
CREATE INDEX "#__jcomments_subscriptions_idx_hash" ON "#__jcomments_subscriptions" ("hash");

CREATE TABLE "#__jcomments_version" (
"version" VARCHAR(16) NOT NULL DEFAULT '',
"previous" VARCHAR(16) NOT NULL DEFAULT '',
"installed" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"updated" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
PRIMARY KEY  ("version")
);

CREATE TABLE "#__jcomments_custom_bbcodes" (
"id" serial NOT NULL,
"name" VARCHAR(64) NOT NULL DEFAULT '',
"simple_pattern" VARCHAR(255) NOT NULL DEFAULT '',
"simple_replacement_html" TEXT NOT NULL DEFAULT '',
"simple_replacement_text" TEXT NOT NULL DEFAULT '',
"pattern" VARCHAR(255) NOT NULL DEFAULT '',
"replacement_html" TEXT NOT NULL DEFAULT '',
"replacement_text" TEXT NOT NULL DEFAULT '',
"button_acl" TEXT NOT NULL DEFAULT '',
"button_open_tag" VARCHAR(16) NOT NULL DEFAULT '',
"button_close_tag" VARCHAR(16) NOT NULL DEFAULT '',
"button_title" VARCHAR(255) NOT NULL DEFAULT '',
"button_prompt" VARCHAR(255) NOT NULL DEFAULT '',
"button_image" VARCHAR(255) NOT NULL DEFAULT '',
"button_css" VARCHAR(255) NOT NULL DEFAULT '',
"button_enabled" smallint NOT NULL DEFAULT 0,
"ordering" bigint NOT NULL DEFAULT 0,
"published" smallint NOT NULL DEFAULT 0,
"checked_out" bigint NOT NULL DEFAULT 0,
"checked_out_time" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
PRIMARY KEY  ("id")
);

CREATE TABLE "#__jcomments_reports" (
"id" serial NOT NULL,
"commentid" bigint NOT NULL DEFAULT 0,
"userid" bigint NOT NULL DEFAULT 0,
"name"VARCHAR(255) NOT NULL DEFAULT '',
"ip" VARCHAR(39) NOT NULL DEFAULT '',
"date" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"reason" VARCHAR(255) NOT NULL,
"status" smallint NOT NULL DEFAULT 0,
PRIMARY KEY  ("id")
);

CREATE TABLE "#__jcomments_blacklist" (
"id" serial NOT NULL,
"ip" VARCHAR(39) NOT NULL DEFAULT '',
"userid" bigint NOT NULL DEFAULT 0,
"created" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"created_by" bigint NOT NULL DEFAULT 0,
"expire" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"reason" VARCHAR(255) NOT NULL,
"notes" VARCHAR(255) NOT NULL,
"checked_out" bigint NOT NULL DEFAULT 0,
"checked_out_time" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
"editor" VARCHAR(50) DEFAULT NULL,
PRIMARY KEY  ("id")
);
CREATE INDEX "#__jcomments_blacklist_idx_checkout" ON "#__jcomments_blacklist" ("checked_out");
CREATE INDEX "#__jcomments_blacklist_idx_ip" ON "#__jcomments_blacklist" ("ip");


CREATE TABLE "#__jcomments_objects" (
"id" serial NOT NULL,
"object_id" bigint NOT NULL DEFAULT 0,
"object_group" VARCHAR(255) NOT NULL DEFAULT '',
"category_id" bigint NOT NULL DEFAULT 0,
"lang" VARCHAR(20) NOT NULL DEFAULT '',
"title" VARCHAR(255) NOT NULL DEFAULT '',
"link" text NOT NULL DEFAULT '',
"access" smallint NOT NULL DEFAULT 0,
"userid" bigint NOT NULL DEFAULT 0,
"expired" smallint NOT NULL DEFAULT 0,
"modified" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
PRIMARY KEY  ("id")
);
CREATE INDEX "#__jcomments_objects_idx_object" ON "#__jcomments_objects" ("object_id", "object_group", "lang");

CREATE TABLE "#__jcomments_mailq" (
"id" serial NOT NULL,
"name" varchar(255) NOT NULL,
"email" varchar(255) NOT NULL,
"subject" text NOT NULL,
"body" text NOT NULL,
"created" timestamp NOT NULL,
"attempts" smallint NOT NULL DEFAULT 0,
"priority" smallint NOT NULL DEFAULT 0,
"session_id" VARCHAR(200) DEFAULT NULL,
PRIMARY KEY  ("id")
);
CREATE INDEX "#__jcomments_mailq_idx_priority" ON "#__jcomments_mailq" ("priority");
CREATE INDEX "#__jcomments_mailq_idx_attempts" ON "#__jcomments_mailq" ("attempts");

CREATE TABLE "#__jcomments_smilies" (
"id" serial NOT NULL,
"code" varchar(39) NOT NULL DEFAULT '',
"alias" varchar(39) NOT NULL DEFAULT '',
"image" varchar(255) NOT NULL,
"name" varchar(255) NOT NULL,
"published" smallint NOT NULL DEFAULT 0,
"ordering" bigint NOT NULL DEFAULT 0,
"checked_out" bigint NOT NULL DEFAULT 0,
"checked_out_time" timestamp DEFAULT '1970-01-01 00:00:00' NOT NULL,
PRIMARY KEY ("id")
);
CREATE INDEX "#__jcomments_smilies_idx_checkout" ON "#__jcomments_smilies" ("checked_out");
