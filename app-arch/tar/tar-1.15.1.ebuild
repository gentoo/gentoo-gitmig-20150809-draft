# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.15.1.ebuild,v 1.7 2005/04/07 01:49:24 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://ftp.gnu.org/gnu/tar/${P}.tar.bz2
	http://alpha.gnu.org/gnu/tar/${P}.tar.bz2
	mirror://gnu/tar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE="nls static build"

DEPEND="app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"
RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-flex-arg.patch
	epatch "${FILESDIR}"/${P}-gcc4-test.patch
}

src_compile() {
	use static && append-ldflags -static
	# Work around bug in sandbox #67051
	gl_cv_func_chown_follows_symlink=yes \
	econf \
		--enable-backup-scripts \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# a nasty yet required symlink:
	dodir /etc
	dosym ../usr/sbin/rmt /etc/rmt
	if use build ; then
		rm -r "${D}"/usr
	else
		dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
		doman "${FILESDIR}"/tar.1
		mv "${D}"/usr/sbin/backup{,-tar}
		mv "${D}"/usr/sbin/restore{,-tar}
	fi
}
