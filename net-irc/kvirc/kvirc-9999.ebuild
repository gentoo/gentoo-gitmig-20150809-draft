# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-9999.ebuild,v 1.2 2006/06/06 06:08:16 jokey Exp $

inherit kde cvs

DESCRIPTION="An advanced IRC Client"
HOMEPAGE="http://www.kvirc.net"

LICENSE="kvirc"
SLOT="3"
KEYWORDS="-*"
IUSE="arts debug esd ipv6 kde oss ssl"

DEPEND="esd? ( media-sound/esound )
	oss? ( media-libs/audiofile )
	ssl? ( dev-libs/openssl )"

ECVS_SERVER="cvs.kvirc.net:/cvs"
ECVS_MODULE="kvirccvs/kvirc"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${P}"

S="${WORKDIR}/${ECVS_MODULE}"

if use kde ; then
	need-kde 3.3
else
	need-qt 3
fi

src_unpack() {
	cvs_src_unpack
}

src_compile() {
	set-qtdir 3
	set-kdedir 3

	local myconf

	export myconf="${myconf} \
		--with-aa-fonts --with-big-channels --with-pizza \
		$(use_with arts arts-support) \
		$(use_with debug debug-symbols) \
		$(use_with esd esd-support) \
		$(use_with ipv6 ipv6-support) \
		$(use_with kde kde-support) \
		$(use_with oss af-support) \
		$(use_with ssl ssl-support)"

	export WANT_AUTOCONF="2.5"
	export WANT_AUTOMAKE="1.5"

	./autogen.sh
	econf ${myconf} || dir "failed to configure"
	emake -j1 || die "failed to make"
}

src_install() {
	make install docs DESTDIR=${D} || die "make install failed"
	dodoc ChangeLog README TODO
}

