# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sandboxshell/sandboxshell-0.3-r2.ebuild,v 1.1 2006/11/05 10:40:05 betelgeuse Exp $

DESCRIPTION="launch a sandboxed shell ... useful for debugging ebuilds"
HOMEPAGE="http://wh0rd.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

# Portage 2.1.1 changes the /var/tmp/portage structure from <pkg> to <cat>/<pkg>
RDEPEND=">sys-apps/portage-2.1.1
	app-shells/bash"

S=${WORKDIR}

src_install() {
	dobin "${FILESDIR}"/sandboxshell || die
	doman "${FILESDIR}"/sandboxshell.1
	insinto /etc
	doins "${FILESDIR}"/sandboxshell-r1.conf
}
