# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vanessa-adt/vanessa-adt-0.0.6.ebuild,v 1.2 2004/09/04 22:56:04 dholm Exp $

DESCRIPTION="Provides Abstract Data Types (ADTs) Includes queue, dynamic array, hash and key value ADT."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/vanessa_adt/0.0.6/vanessa_adt-0.0.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/vanessa-logger-0.0.6"
S=${WORKDIR}/vanessa_adt-0.0.6

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README TODO
}
