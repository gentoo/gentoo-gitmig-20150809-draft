# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-1.0.13-r2.ebuild,v 1.6 2002/08/16 04:09:24 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libgtop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=">=sys-devel/bc-1.06
	 >=sys-libs/readline-4.1
         >=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext ) 
	sys-devel/perl"


src_unpack() {

	unpack ${A}

	# Fix a remote buffer overflow vuln.
	cd ${S}
	patch -p1 <${FILESDIR}/${PV}-remote_buffer_overflow.diff || die
}

src_compile() {

	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
	            --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --infodir=/usr/share/info				\
		    ${myconf} || die

	emake || die
}

src_install() {

        cd ${S}/doc
	# Add a INFO-DIR-SECTION section to the info file
	patch <${FILESDIR}/libgtop.info.diff || die
	cd ${S}

	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
             localstatedir=${D}/var/lib					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog INSTALL LIBGTOP*
	dodoc NEWS RELNOTES* README
}

