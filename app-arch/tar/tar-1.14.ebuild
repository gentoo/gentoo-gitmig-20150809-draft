# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.14.ebuild,v 1.12 2004/08/05 04:15:24 vapier Exp $

inherit flag-o-matic eutils gnuconfig

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://ftp.gnu.org/gnu/tar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha arm hppa amd64 ia64 ~ppc64 ~s390"
IUSE="nls static build"

DEPEND="virtual/libc
	app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"
RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	use static && append-ldflags -static
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	#FHS 2.1 stuff
	cd "${D}/usr/sbin"
	mv rmt rmt.gnu || die "mv failed"
	dosym rmt.gnu /usr/sbin/rmt
	# a nasty yet required symlink:
	dodir /etc
	dosym /usr/sbin/rmt /etc/rmt
	cd "${S}"
	if use build ; then
		rm -rf "${D}/usr/share"
		rm -rf ${D}/usr/sbin/rmt ${D}/etc/rmt
	else
		dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
		doman "${FILESDIR}/tar.1"
	fi
}
