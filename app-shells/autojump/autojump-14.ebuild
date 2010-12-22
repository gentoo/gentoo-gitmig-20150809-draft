# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/autojump/autojump-14.ebuild,v 1.1 2010/12/22 23:47:00 xmw Exp $

EAPI=3

PYTHON_DEPEND="*"

inherit python

DESCRIPTION="change directory command that learns"
HOMEPAGE="http://github.com/joelthelion/autojump"
MY_P=${PN}_v${PV}
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion gtk zsh-completion"

RDEPEND="gtk? ( dev-python/pygtk:2 )
	bash-completion? ( >=app-shells/bash-4 )
	zsh-completion? ( app-shells/zsh app-shells/zsh-completion )"

S=${WORKDIR}/${MY_P}

src_install() {
	dobin autojump || die

	if use gtk ; then
		dobin jumpapplet || die
		insinto /usr/share/${PN}
		doins icon.png || die
	fi

	insinto /etc/profile.d
	doins ${PN}.sh || die

	if use bash-completion ; then
		doins ${PN}.bash || die
	fi

	if use zsh-completion ; then
		doins ${PN}.zsh || die
		insinto /usr/share/zsh/site-functions
		doins _j || die
	fi

	doman ${PN}.1 || die
	dodoc README.rst || die
}
