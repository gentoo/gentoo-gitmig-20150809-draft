# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xsim/xsim-0.3.9.4-r1.ebuild,v 1.1 2003/05/25 13:44:45 liquidx Exp $

[ -n "`use kde`" ] && inherit kde

DESCRIPTION="A simple and fast GB and BIG5 Chinese XIM server."
HOMEPAGE="http://developer.berlios.de/projects/xsim/"
SRC_URI="http://download.berlios.de/xsim/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde"

DEPEND="virtual/glibc
	=sys-libs/db-3*
	kde? ( >=kde-base/kdelibs-3 )"

src_unpack() {
	unpack ${A}
	
	epatch ${FILESDIR}/${P}-db3.patch

	cd ${S}
	einfo "Patching ./configure to respect CFLAGS .."
	sed -i -e "s/\(CFLAGS.*\)-O2/\1${CFLAGS}/" configure
	
}

src_compile() {

	local myconf

	myconf="${myconf} --with-bdb-includes=/usr/include/db3 --with-bdb-libs=/usr/lib"

	use kde \
		&& myconf="${myconf} --with-kde3=${KDEDIR} --with-qt3=${QTDIR} --enable-status-kde3"

	econf ${myconf} || die "configure failed"
	emake xsim_etcp=/etc || die "make failed"
}

src_install () {
	einstall xsim_datp=${D}/usr/lib/xsim/dat \
			 xsim_libp=${D}/usr/lib/xsim/plugins \
			 xsim_binp=${D}/usr/bin \
			 xsim_etcp=${D}/etc \
			 install-data install || die "install failed"
	
	sed -i -e "s#DICT_LOCAL\(.*\)/usr/dat#DICT_LOCAL\1/usr/lib/xsim/dat#" \
		-e "s#PLUGIN_LOCAL\(.*\)/usr/plugins#PLUGIN_LOCAL\1/usr/lib/xsim/plugins#" \
		${D}/etc/xsimrc
	
	dodoc ChangeLog COPYING INSTALL README* TODO
}

pkg_postinst() {
	einfo "XSIM needs write access to /usr/lib/xsim/dat/chardb, so if you"
	einfo "not running it as root, you need to do the following:"
	echo
	einfo "  cp -r /usr/lib/xsim/dat \${HOME}/.xsim"
	einfo "  sed -i \"s#DICT_LOCAL.*#DICT_LOCAL \${HOME}/.xsim#\" > \${HOME}/.xsim/xsimrc"
	echo
}
