# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kurso-de-esperanto/kurso-de-esperanto-3.0.ebuild,v 1.6 2005/01/12 20:48:36 luckyduck Exp $

DESCRIPTION="multimedia computer program for teaching yourself Esperanto"
HOMEPAGE="http://www.cursodeesperanto.com.br/"
SRC_URI="http://www.cursodeesperanto.com.br/kurso.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE="emul-linux-x86"
KEYWORDS="-* x86 ~amd64"

RDEPEND="emul-linux-x86? ( >=app-emulation/emul-linux-x86-qtlibs-1.1 )"

S=${WORKDIR}

src_install() {
	dodir /opt/kurso
	tar -zxf kurso-inst.tar.gz -C ${D}/opt/kurso/
	dobin ${FILESDIR}/kurso

	# Workaround till lib symlink changes from lib->lib64 to lib->lib32
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	if use amd64 ; then
		sed -i -e "s:^\#export:export:" ${D}/usr/bin/kurso
	fi

	insinto /etc
	doins ${FILESDIR}/kurso.conf
}
