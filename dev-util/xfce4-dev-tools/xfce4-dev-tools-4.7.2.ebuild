# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xfce4-dev-tools/xfce4-dev-tools-4.7.2.ebuild,v 1.8 2010/08/01 18:51:52 armin76 Exp $

EAPI=2
inherit xfconf

DESCRIPTION="set of scripts and m4/autoconf macros that ease build system maintenance for XFCE"
HOMEPAGE="http://foo-projects.org/~benny/projects/xfce4-dev-tools"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris"
IUSE=""

DOCS="AUTHORS ChangeLog HACKING NEWS README"
