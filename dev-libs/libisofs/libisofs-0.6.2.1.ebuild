# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libisofs/libisofs-0.6.2.1.ebuild,v 1.1 2008/02/25 02:00:27 beandog Exp $

DESCRIPTION="libisofs is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia.pykix.org/"
SRC_URI="http://files.libburnia.pykix.org/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND=""
DEPEND=">=dev-libs/libburn-0.4.2
	>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS CONTRIBUTORS README doc/comments NEWS Roadmapi TODO"
