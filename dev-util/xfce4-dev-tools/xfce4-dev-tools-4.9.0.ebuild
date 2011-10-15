# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xfce4-dev-tools/xfce4-dev-tools-4.9.0.ebuild,v 1.1 2011/10/15 11:53:50 angelos Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Xfce's build scripts and aclocal macros"
HOMEPAGE="http://www.xfce.org/ http://foo-projects.org/~benny/projects/xfce4-dev-tools/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.9/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris"
IUSE=""

pkg_setup() {
	DOCS=( AUTHORS ChangeLog HACKING NEWS README )
}
