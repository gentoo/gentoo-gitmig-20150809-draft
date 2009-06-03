# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libffi/libffi-0.ebuild,v 1.7 2009/06/03 11:55:37 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual for dev-libs/libffi"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~sparc ~x86"
IUSE="static-libs"

# When we are using this, we need to package.use.mask libffi
# in sys-devel/gcc.
RDEPEND="dev-libs/libffi[static-libs?]"
DEPEND=""
