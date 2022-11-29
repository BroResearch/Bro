package com.bro.models

import org.jetbrains.exposed.sql.Table

object Articles : Table() {
    val id = integer("id").autoIncrement()
    val title = varchar("title", 128)
    val body = varchar("body", 1024)
    val image = 

    override val primaryKey = PrimaryKey(id)
}