# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gpm/gpm-1.20.1-r4.ebuild,v 1.8 2005/04/01 22:20:49 pylon Exp $

inherit eutils toolchain-funcs

PATCH_VER="1.3"
DESCRIPTION="Console-based mouse driver"
HOMEPAGE="http://linux.schottelius.org/gpm/"
SRC_URI="ftp://arcana.linux.it/pub/gpm/${P}.tar.bz2
	ftp://ftp.schottelius.org/pub/linux/gpm/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="selinux"

DEPEND="sys-libs/ncurses"
RDEPEND="selinux? ( sec-policy/selinux-gpm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/patch
}

src_compile() {
	econf \
		--libdir=/$(get_libdir) \
		--sysconfdir=/etc/gpm \
		|| die "econf failed"
	emake \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB) \
		|| die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	# fix lib symlinks since the default is missing/bogus
	dosym libgpm.so.1.19.0 /$(get_libdir)/libgpm.so.1
	dosym libgpm.so.1 /$(get_libdir)/libgpm.so
	dodir /usr/$(get_libdir)
	mv "${D}"/$(get_libdir)/*.a "${D}"/usr/$(get_libdir)/
	gen_usr_ldscript libgpm.so

	insinto /etc/gpm
	doins conf/gpm-*.conf

	dodoc BUGS Changes README TODO
	dodoc doc/Announce doc/FAQ doc/README*

	newinitd "${FILESDIR}"/gpm.rc6 gpm
	newconfd "${FILESDIR}"/gpm.conf.d gpm
}
