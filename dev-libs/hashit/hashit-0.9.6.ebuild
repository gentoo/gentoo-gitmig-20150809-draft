# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hashit/hashit-0.9.6.ebuild,v 1.1 2009/04/24 09:51:50 patrick Exp $

inherit cmake-utils

DESCRIPTION="Hashit is a library of generic hash tables that supports different collision handling methods with one common interface. Both data and keys can be of any type. It is small and easy to use."
HOMEPAGE="http://www.pleyades.net/david/projects/"
SRC_URI="http://www.pleyades.net/david/projects/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"
DEPEND=""

