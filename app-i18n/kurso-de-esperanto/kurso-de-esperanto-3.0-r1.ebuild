# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kurso-de-esperanto/kurso-de-esperanto-3.0-r1.ebuild,v 1.1 2007/01/27 11:47:47 vapier Exp $

DESCRIPTION="multimedia computer program for teaching yourself Esperanto"
HOMEPAGE="http://www.cursodeesperanto.com.br/"
SRC_URI="http://www.cursodeesperanto.com.br/kurso.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-qtlibs-1.1 )"

S=${WORKDIR}

src_install() {
	dodir /opt/kurso
	cd "${D}"/opt/kurso
	ln -s "${S}"/kurso-inst.tar.gz
	unpack ./kurso-inst.tar.gz
	rm -f kurso-inst.tar.gz
	dobin "${FILESDIR}"/kurso || die

	# Workaround till lib symlink changes from lib->lib64 to lib->lib32
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	if use amd64 ; then
		sed -i -e "s:^\#export:export:" "${D}"/usr/bin/kurso
	fi

	insinto /etc
	doins "${FILESDIR}"/kurso.conf

	ls -l "${D}"/opt/kurso/fonts/
}
