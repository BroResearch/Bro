package plugin

import dao.DAOFacade
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import org.joda.time.DateTime

/**
 * Implementations of serialize and deserialize methods
 * for [DateTime]
 */
object DateAsLongSerializer : KSerializer<DateTime> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("Date", PrimitiveKind.LONG)
    override fun serialize(encoder: Encoder, value: DateTime) = encoder.encodeLong(value.millis)
    override fun deserialize(decoder: Decoder): DateTime = DateTime(decoder.decodeLong())
}