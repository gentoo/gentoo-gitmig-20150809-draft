# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/alchemist/alchemist-1.0.36.ebuild,v 1.1 2006/09/05 21:23:57 dberkholz Exp $

inherit rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1.2.2"

DESCRIPTION="A multi-sourced configuration back-end"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-libs/libxml2
	dev-libs/libxslt
	dev-lang/python
	=dev-libs/glib-2*"
DEPEND="${RDEPEND}"

src_install() {
	einstall || die "einstall failed"

	keepdir /var/lib/cache/alchemist
	keepdir /etc/alchemist/namespace
	keepdir /etc/alchemist/switchboard
}
