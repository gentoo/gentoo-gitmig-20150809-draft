# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.10.9.ebuild,v 1.6 2003/07/01 20:51:46 aliz Exp $

S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="Package maintenance system for Debian (no start-stop-dameon, dselect and sgml docs. many for alien)"
SRC_URI="http://ftp.debian.org/debian/pool/main/d/dpkg/${PN}_${PV}.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/base/dpkg.html"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"

SLOT="0"

RDEPEND=">=dev-lang/perl-5.6.0
         >=sys-libs/ncurses-5.2-r7
         >=sys-libs/zlib-1.1.4" #app-text/sgmltools-lite?

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5-r1"
	


src_compile() {
	cd main
	ln -s ../archtable
	cd ..
	econf --without-dselect --without-sgml-doc --without-start-stop-daemon
	make || die "emake failed."
}

src_install() {
	dobin scripts/822-date \
	    main/dpkg \
	    scripts/dpkg-architecture \
	    scripts/dpkg-buildpackage \
	    scripts/dpkg-checkbuilddeps \
	    dpkg-deb/dpkg-deb \
	    scripts/dpkg-distaddfile \
	    scripts/dpkg-genchanges \
	    scripts/dpkg-gencontrol \
	    scripts/dpkg-name \
	    scripts/dpkg-parsechangelog \
	    main/dpkg-query \
	    scripts/dpkg-scanpackages \
	    scripts/dpkg-scansources \
	    scripts/dpkg-shlibdeps \
	    scripts/dpkg-source \
	    split/dpkg-split
	dodir /etc/alternatives
	insinto /etc/alternatives
	doins scripts/README.alternatives
	dosbin scripts/update-alternatives scripts/dpkg-divert scripts/dpkg-statoverride
	dodoc ABOUT-NLS COPYING ChangeLog INSTALL THANKS TODO
}
