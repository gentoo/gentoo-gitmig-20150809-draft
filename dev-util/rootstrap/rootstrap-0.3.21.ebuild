# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rootstrap/rootstrap-0.3.21.ebuild,v 1.6 2005/03/30 04:25:16 vapier Exp $

inherit eutils

DESCRIPTION="A tool for building complete Linux filesystem images"
HOMEPAGE="http://packages.qa.debian.org/rootstrap"
SRC_URI="mirror://debian/pool/main/r/rootstrap/rootstrap_${PV}.orig.tar.gz
	mirror://debian/pool/main/r/rootstrap/rootstrap_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| ( sys-kernel/usermode-sources >=sys-kernel/vanilla-sources-2.6 )
	dev-util/debootstrap
	app-arch/dpkg
	dev-lang/python
	app-text/docbook-sgml-utils"

S=${WORKDIR}/rootstrap-${PV}.orig

src_unpack() {
	unpack rootstrap_${PV}.orig.tar.gz
	epatch "${DISTDIR}"/rootstrap_${PV}-1.diff.gz
	cd "${S}"
	sed -i -e "s/docbook-to-man/docbook2man/" Makefile
}

src_install() {
	make DESTDIR="${D}" install || die
}
