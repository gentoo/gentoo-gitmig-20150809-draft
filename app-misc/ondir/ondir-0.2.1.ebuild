# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ondir/ondir-0.2.1.ebuild,v 1.6 2004/07/10 14:45:53 slarti Exp $

inherit eutils

DESCRIPTION="program that automatically executes scripts as you traverse directories"
HOMEPAGE="http://ondir.sourceforge.net/"
SRC_URI="http://ondir.sourceforge.net/${PV}/ondir-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	emake PREFIX=/usr CONF=/etc/ondirrc || die "Make failed"
}

src_install() {
	## EXEs
	exeinto /usr/bin
	exeopts -oroot -groot -m0755
	doexe ondir
	## MISC
	insinto /usr/share/${PN}
	insopts -oroot -groot -m0755
	doins scripts.sh scripts.tcsh
	insopts -oroot -groot -m0644
	doins ondirrc.eg
	## DOCS
	dodoc AUTHORS ChangeLog INSTALL README TODO
	doman ondir.1
}
