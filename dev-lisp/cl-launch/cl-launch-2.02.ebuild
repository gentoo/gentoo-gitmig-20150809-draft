# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-launch/cl-launch-2.02.ebuild,v 1.1 2006/11/19 07:34:13 mkennedy Exp $

inherit eutils common-lisp

DESCRIPTION="cl-launch is a utility to make Common Lisp software easily invokable from the command-line."
HOMEPAGE="http://www.cliki.net/cl-launch"
SRC_URI="http://fare.tunes.org/files/cl-launch/cl-launch_${PV}.orig.tar.gz"
LICENSE="No-Problem-Bugroff LLGPL-2.1"
SLOT="0"
KEYWORDS="~sparc ~ppc ~amd64 ~x86"
IUSE=""
DEPEND=""

CLPACKAGE='cl-launch'

src_compile() {
	./cl-launch.sh -I /usr/share/common-lisp/cl-launch \
		-B generate_install_files
	./cl-launch.sh -I /usr/share/common-lisp/cl-launch \
		-B print_cl_launch_asd >cl-launch.asd
}

src_install() {
	dobin cl-launch
	common-lisp-install header.lisp wrapper.sh cl-launch.asd
	common-lisp-system-symlink
}
