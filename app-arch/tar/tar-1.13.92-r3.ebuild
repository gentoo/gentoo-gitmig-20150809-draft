# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.13.92-r3.ebuild,v 1.5 2004/04/10 07:37:07 mr_bones_ Exp $

inherit eutils gnuconfig


DESCRIPTION="Use this to try make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="ftp://alpha.gnu.org/pub/pub/gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa amd64 ~ia64 ~ppc64 s390"
IUSE="nls static build"

DEPEND="app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Do not strip './' in path elements, as they are valid, bug #37132
	epatch "${FILESDIR}/${P}-dont-strip-dot_slash.patch"
	# Fix -l, --one-file-system option to actually work.
	epatch "${FILESDIR}/${P}-fix-one_file_system.patch"
	# Fix configure scripts to support linux-mips targets
	gnuconfig_update
}

src_compile() {
	econf \
		--bindir=/bin \
		--libexecdir=/usr/lib/misc \
		$(use_enable nls) || die

	if use static ; then
		emake LDFLAGS=-static || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	#FHS 2.1 stuff
	dodir /usr/sbin
	cd "${D}"
	mv usr/lib/misc/rmt usr/sbin/rmt.gnu
	dosym rmt.gnu /usr/sbin/rmt
	# a nasty yet required symlink:
	dodir /etc
	dosym /usr/sbin/rmt /etc/rmt
	cd "${S}"
	if use build ; then
		rm -rf "${D}/usr/share"
	else
		dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
		doman "${FILESDIR}/tar.1"
	fi
}
