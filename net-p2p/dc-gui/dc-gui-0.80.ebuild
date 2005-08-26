# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-gui/dc-gui-0.80.ebuild,v 1.8 2005/08/26 11:05:41 sekretarz Exp $

MY_P=${PN/-/_}2-${PV}
DESCRIPTION="GUI for dctc"
HOMEPAGE="http://brainz.servebeer.com/dctc/"
SRC_URI="http://brainz.servebeer.com/dctc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc ~sparc ~amd64"
IUSE="nls curl"

DEPEND="=dev-libs/glib-2*
	=x11-libs/gtk+-2*
	=gnome-base/libgnomeui-2*
	>=sys-libs/db-3.2
	>=net-p2p/dctc-0.85.9
	curl? ( net-misc/curl )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix for #26708 (db4 support)
	local dbfunc="`grep '^#define.*db_env_create' /usr/include/db.h | awk '{print $NF}'`"
	if [ "${dbfunc}" != "db_env_create" ] ; then
		sed -i "s:db_env_create:${dbfunc}:g" configure
	fi

	if ! use curl ; then
		cd dc_gui2_bt
		sed -i 's:AC_CHECK_PROG(curl_installed.*::' configure.in
		autoconf
		cd ..
	fi

	cd src
	cp ${FILESDIR}/split_interface_fast.pl .
	perl split_interface_fast.pl || die "could not split interface up"
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	use nls || rm -rf ${D}/usr/share/locale
	dodoc AUTHORS ChangeLog NEWS README TODO
}
