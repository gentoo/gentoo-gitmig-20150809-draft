# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="2"

COMPRESSTYPE=".lzma"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="1"

RESTRICT="binchecks strip primaryuri mirror"

ETYPE="sources"

IUSE="+stable"

inherit kernel-2 git
detect_version

K_NOSETEXTRAVERSION="don't_set_it"
DESCRIPTION="The Zen Kernel Live Sources"
HOMEPAGE="http://zen-kernel.org"

if use stable; then
	EGIT_REPO_URI="git://zen-kernel.org/kernel/zen-stable.git"
else
	EGIT_REPO_URI="git://zen-kernel.org/kernel/zen.git"
fi

KEYWORDS=""

K_EXTRAEINFO="For more info on zen-sources, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources on freenode"

pkg_setup(){
	ewarn "Be carefull!! You are about to install live kernel sources."
	ewarn "Git zen-sources are extremely unsupported, even from the upstream"
	ewarn "developers. Use them at your own risk and don't bite us if your"
	ewarn "system explodes"
	ebeep 10
	ewarn
	if use stable; then
		ewarn "stable use flag is enabled. This means that you will install"
		ewarn "${PN} from stable git tree."
	else
		ewarn "WARNING! stable use flag is disabled. You will install ${PN}"
		ewarn "from unstable git tree"
	fi
	ebeep 10
	kernel-2_pkg_setup
}
