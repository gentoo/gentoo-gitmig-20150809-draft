# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.13.92-r3.ebuild,v 1.2 2004/02/17 08:43:24 mr_bones_ Exp $

inherit eutils gnuconfig

IUSE="nls static build"

S="${WORKDIR}/${P}"
DESCRIPTION="Use this to try make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="ftp://alpha.gnu.org/pub/pub/gnu/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64 ~ia64 ~ppc64"

DEPEND="app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Do not strip './' in path elements, as they are valid, bug #37132
	epatch ${FILESDIR}/${P}-dont-strip-dot_slash.patch
	# Fix -l, --one-file-system option to actually work.
	epatch ${FILESDIR}/${P}-fix-one_file_system.patch
}

src_compile() {

	# Fix configure scripts to support linux-mips targets
	gnuconfig_update

	econf \
		--bindir=/bin \
		--libexecdir=/usr/lib/misc \
		`use_enable nls` || die

	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	#FHS 2.1 stuff
	dodir /usr/sbin
	cd ${D}
	mv usr/lib/misc/rmt usr/sbin/rmt.gnu
	dosym rmt.gnu /usr/sbin/rmt
	# a nasty yet required symlink:
	dodir /etc
	dosym /usr/sbin/rmt /etc/rmt
	cd ${S}
	if [ -z "`use build`" ]
	then
		dodoc AUTHORS ChangeLog* COPYING NEWS README* PORTS THANKS
		doman ${FILESDIR}/tar.1
	else
		rm -rf ${D}/usr/share
	fi
}
