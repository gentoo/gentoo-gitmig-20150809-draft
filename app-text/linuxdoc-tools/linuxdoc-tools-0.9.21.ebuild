# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/linuxdoc-tools/linuxdoc-tools-0.9.21.ebuild,v 1.1 2005/08/13 10:27:01 leonardop Exp $

inherit sgml-catalog

DESCRIPTION="A toolset for processing LinuxDoc DTD SGML files"
HOMEPAGE="http://packages.qa.debian.org/l/linuxdoc-tools.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="KenMacLeod SGMLUG"
SLOT="0"
KEYWORDS="~x86"
IUSE="tetex"

DEPEND="app-text/openjade
	app-text/sgml-common
	>=dev-lang/perl-5.004
	sys-apps/gawk
	!<app-text/sgmltools-lite-3.0.3-r10"

RDEPEND="${DEPEND}
	tetex? ( app-text/tetex )"

sgml-catalog_cat_include "/etc/sgml/linuxdoc.cat" \
	"/usr/share/linuxdoc-tools/linuxdoc-tools.catalog"


src_compile() {
	local myconf="--with-installed-iso-entities"

	econf $myconf || die "./configure failed"
	emake || die "Compilation failed"
}

src_install() {
	eval `perl -V:installvendorarch`
	einstall \
		perl5libdir="${D}${installvendorarch}" \
		LINUXDOCDOC="${D}/usr/share/doc/${PF}/guide" \
		|| die "Installation failed"

	dodoc ChangeLog README
}
