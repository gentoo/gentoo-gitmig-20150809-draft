# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/easygit/easygit-1.6.5.5.ebuild,v 1.1 2010/01/08 00:13:47 spatz Exp $

EAPI="2"

MY_PN="eg"

DESCRIPTION="Easy GIT is a wrapper for git, designed to make git easy to learn and use."
HOMEPAGE="http://www.gnome.org/~newren/eg/"
SRC_URI="http://www.gnome.org/~newren/${MY_PN}/download/${PV}/${MY_PN} -> ${PF}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=dev-util/git-${PV}
	dev-lang/perl"

src_install() {
	newbin "${DISTDIR}/${PF}" "${MY_PN}" || die
}
