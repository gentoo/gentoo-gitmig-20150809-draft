# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-2.6-r1.ebuild,v 1.2 2004/03/22 20:12:08 eradicator Exp $

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
HOMEPAGE="http://www.gnump3d.org/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-lang/perl-5.8.0"

LIBDIR=/usr/lib/gnump3d

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
	cd ${S}/bin
	for binary in gnump3d-index gnump3d2; do
		sed -i "s,#!/usr/bin/perl,#!/usr/bin/perl -I${LIBDIR},g" $binary
	done
}

src_install() {
	insinto ${LIBDIR}/gnump3d; doins lib/gnump3d/*.pm
	insinto ${LIBDIR}/gnump3d/plugins; doins lib/gnump3d/plugins/*.pm
	insinto ${LIBDIR}/gnump3d/lang; doins lib/gnump3d/lang/*.pm
	dobin bin/gnump3d2 bin/gnump3d-top bin/gnump3d-index
	dosym /usr/bin/gnump3d2 /usr/bin/gnump3d
	doman man/*.1
	dodir /usr/share/gnump3d; cp -R templates/* ${D}/usr/share/gnump3d/
	insinto /etc/gnump3d
	doins etc/mime.types
	sed -e "s,PLUGINDIR,${LIBDIR},g" \
		-e 's,^user *= *\(.*\)$,user = gnump3d,g' \
		etc/gnump3d.conf >${D}/etc/gnump3d/gnump3d.conf

	dodoc AUTHORS ChangeLog README COPYING TODO

	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}-initd gnump3d
	dodir /etc/env.d
	cat >${D}/etc/env.d/50gnump3d <<EOF
# PERL5LIB="${LIBDIR}"
EOF
	dodir /var/log/gnump3d
	dodir /var/cache/gnump3d/serving

	keepdir /var/log/gnump3d
	keepdir /var/cache/gnump3d/serving

	touch ${D}/var/cache/gnump3d/song.tags
	touch ${D}/var/cache/gnump3d/serving/.keep
}

pkg_postinst() {
	enewuser gnump3d '' '' '' nogroup
	chown -R gnump3d /var/log/gnump3d
	chown -R gnump3d /var/cache/gnump3d
	while read line; do einfo "${line}"; done <<EOF

Please edit your /etc/gnump3d/gnump3d.conf before running
/etc/init.d/gnump3d start

EOF
}
