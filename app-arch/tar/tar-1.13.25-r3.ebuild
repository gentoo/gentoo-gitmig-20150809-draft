# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.13.25-r3.ebuild,v 1.9 2004/08/05 04:15:24 vapier Exp $

inherit eutils gnuconfig

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gnu/tar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 alpha mips hppa ppc ia64 sparc ppc64"
IUSE="nls static build"

DEPEND="app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PF}.gentoo.diff"
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
