# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-2.8.ebuild,v 1.6 2004/11/03 16:50:06 corsair Exp $

IUSE=""

inherit eutils

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
HOMEPAGE="http://www.gnump3d.org/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc amd64 ~ppc64"

DEPEND="sys-apps/sed"

RDEPEND=">=dev-lang/perl-5.8.0"

LIBDIR=/usr/$(get_libdir)/gnump3d

pkg_setup() {
	enewuser gnump3d '' '' '' nogroup || die
}

src_unpack() {
	unpack ${A}
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
	doins etc/gnump3d.conf
	dosed "s,PLUGINDIR,${LIBDIR},g" /etc/gnump3d/gnump3d.conf
	dosed 's,^user *= *\(.*\)$,user = gnump3d,g' /etc/gnump3d/gnump3d.conf

	dodoc AUTHORS ChangeLog README COPYING TODO

	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init.d gnump3d

	insinto /etc/conf.d
	newins ${FILESDIR}/${PN}.conf.d gnump3d

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
	chown -R gnump3d:nogroup /var/log/gnump3d
	chown -R gnump3d:nogroup /var/cache/gnump3d
	while read line; do einfo "${line}"; done <<EOF

Please edit your /etc/gnump3d/gnump3d.conf before running
/etc/init.d/gnump3d start

EOF
}
