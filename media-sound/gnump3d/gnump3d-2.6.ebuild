# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-2.6.ebuild,v 1.2 2004/01/30 11:17:59 vapier Exp $

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
HOMEPAGE="http://gnump3d.sourceforge.net/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/perl-5.8.0"

src_install() {
	local LIBDIR=/usr/lib/gnump3d
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
	newexe ${FILESDIR}/gnump3d-${PV}-initd gnump3d
	dodir /etc/env.d
	cat >${D}/etc/env.d/50gnump3d <<EOF
PERL5LIB="${LIBDIR}"
EOF
	dodir /var/log/gnump3d
	keepdir /var/cache/gnump3d/serving
}

pkg_postinst() {
	enewuser gnump3d '' '' '' nogroup
	chown -R gnump3d /var/log/gnump3d
	chown -R gnump3d /var/cache/gnump3d
	while read line; do einfo "${line}"; done <<EOF

The default directory for shared mp3s is /home/mp3.  Please edit your
/etc/gnump3d/gnump3d.conf before running /etc/init.d/gnump3d start

EOF
}
