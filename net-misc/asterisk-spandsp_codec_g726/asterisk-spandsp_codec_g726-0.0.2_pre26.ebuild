# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-spandsp_codec_g726/asterisk-spandsp_codec_g726-0.0.2_pre26.ebuild,v 1.1 2006/10/07 23:07:48 sbriesen Exp $

inherit eutils toolchain-funcs

LIB_CODEC_G726="codec_g726-32"
SRC_CODEC_G726="spandsp-${PV/_}_codec_g726.c"

DESCRIPTION="SpanDSP ITU G.726-32kbps codec for Asterisk"
HOMEPAGE="http://soft-switch.org/downloads/spandsp/spandsp-0.0.2pre26/"
SRC_URI="mirror://gentoo/${SRC_CODEC_G726}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=media-libs/spandsp-0.0.2_pre26
	>=net-misc/asterisk-1.2.0"

S="${WORKDIR}"

do_compile() {
	echo "${@}" && "${@}"
}

src_unpack() {
	unpack "${A}"

	# patch include declarations
	sed -e 's:^\(#include.*\)"\(asterisk/.*\)":\1<\2>:g' \
		-e 's:^\(#include.*\)"\(asterisk\.h\)":\1<asterisk/\2>:g' \
		"${SRC_CODEC_G726}" > "${LIB_CODEC_G726}.c" \
	|| die "unpack failed"
}

src_compile() {
	do_compile $(tc-getCC) -D_GNU_SOURCE -fPIC ${CFLAGS} ${LDFLAGS} -lspandsp -lm \
		-shared -o ${LIB_CODEC_G726}.so ${LIB_CODEC_G726}.c || die "compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/asterisk/modules
	doexe ${LIB_CODEC_G726}.so
}

pkg_postinst() {
	einfo
	einfo "To enable the SpanDSP G.726-32 codec, you have to"
	einfo "disable the G.726 codec shipped with Asterisk in"
	einfo "your /etc/asterisk/modules.conf:"
	einfo
	einfo "  noload => codec_g726.so"
	einfo
	einfo "Now you can use the SpanDSP codec instead:"
	einfo
	einfo "  load => ${LIB_CODEC_G726}.so"
	einfo
}
