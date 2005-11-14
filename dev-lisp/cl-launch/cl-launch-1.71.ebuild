# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-launch/cl-launch-1.71.ebuild,v 1.1 2005/11/14 20:13:26 mkennedy Exp $

inherit eutils

DESCRIPTION="cl-launch is a utility to make Common Lisp software easily invokable from the command-line."
HOMEPAGE="http://www.cliki.net/cl-launch"
SRC_URI="http://fare.tunes.org/files/cl-launch/${PN}_${PV}-1.tar.gz"
LICENSE="No-Problem-Bugroff LLGPL-2.1"
SLOT="0"

KEYWORDS="~sparc ~ppc ~amd64 ~x86"

IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	./cl-launch.sh -I /usr/share/common-lisp/cl-launch \
		-B generate_install_files
}

src_install() {
	dobin cl-launch
	insinto /usr/share/common-lisp/cl-launch
	doins header.lisp wrapper.sh
	doman debian/*.1
	dodoc debian/{changelog,copyright}
}
