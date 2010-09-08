# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nvclock/nvclock-9999.ebuild,v 1.1 2010/09/08 05:37:38 jer Exp $

EAPI="2"

inherit autotools cvs eutils toolchain-funcs

ECVS_SERVER="nvclock.cvs.sourceforge.net:/cvsroot/nvclock"
ECVS_MODULE="nvclock"
ECVS_USER="anonymous"
ECVS_PASS=""

DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	gtk? ( x11-libs/gtk+:2 )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
	sed -i \
		-e 's|^CC=|CC?=|g' \
		-e 's|^CFLAGS=|CFLAGS+=|g' \
		-e '/-o .* /s|-o |$(LDFLAGS) -o |g' \
		$( find . -name Makefile.in ) \
		|| die "Fixing compiler flags"
	sed -i src/Makefile.in \
		-e '/LIBS=@X11_LIBS@/{s|@X11_LIBS@||g;s|-lnvcontrol|& @X11_LIBS@|g}' \
		|| die "Fixing Makefile.in"
}

src_configure() {
	tc-export CC
	econf --disable-qt $(use_enable gtk) || die "econf failed"
}

src_compile() {
	# The build fails with -j[N>1]
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin
	einstall || die "einstall failed"
	dodoc AUTHORS README

	newinitd "${FILESDIR}"/nvclock_initd nvclock
	newconfd "${FILESDIR}"/nvclock_confd nvclock
}

pkg_postinst() {
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
