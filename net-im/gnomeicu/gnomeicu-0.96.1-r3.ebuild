# Distributed under the terms of the GNU General Public License, v2 or later
# A Gnome ICQ Clone
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.96.1-r3.ebuild,v 1.1 2001/11/09 22:41:54 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="http://download.sourceforge.net/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
         >=sys-libs/gdbm-1.8.0"

DEPEND="${RDEPEND}
	virtual/glibc
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp ${FILESDIR}/userserver.patch .
	patch -p0 < userserver.patch
}

src_compile() {                           
	local myconf

	if [ -z "`use esd`" ]
	then
		myconf="--disable-esd-test"
	fi
	if [ "`use socks5`" ];
	then
		myconf="${myconf} --enable-socks5"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/log					\
	     install || die

	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO ABOUT-NLS
}
