# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/entropy/entropy-0.8.2.418.ebuild,v 1.2 2005/08/24 00:09:35 vapier Exp $

inherit eutils

MY_PV_BUILD=${PV/*.}
MY_PV=${PV/.${MY_PV_BUILD}}
DESCRIPTION="A p2p-node to share your files, infos, philosophy ... anonymously"
HOMEPAGE="http://entropy.stop1984.com/"
SRC_URI="http://entropy.stop1984.com/files/entropy-${MY_PV}-${MY_PV_BUILD}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql"

DEPEND="sys-libs/zlib
	dev-libs/expat
	mysql? ( dev-db/mysql )"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local myconf=""
	use mysql && myconf="--with-mysql=/usr"
	econf ${myconf} || die
	emake || die
}

src_install() {
	dobin entropy monoopt storechg || die
	exeinto /etc/init.d
	newexe ${FILESDIR}/entropy.rc entropy
	insinto /etc/conf.d
	newins ${FILESDIR}/entropy.conf.d entropy

	pkg_preinst
	diropts -o entropy -g entropy
	insopts -o entropy -g entropy -m0644
	dodir /var/entropy/{de,node,store,tmp}
	insinto /var/entropy/de
	doins de/*
	insinto /var/entropy/node
	doins node/*

	sed -e "3,$ s:#::g" seed.txt-dist > seed.txt
	sed \
		-e "s:seednodes=seed.txt:seednodes=/var/entropy/seed.txt:g" \
		-e "s:logfile=entropy.log:logfile=/var/entropy/entropy.log:g" \
		-e "s:storepath=store:storepath=/var/entropy/store:g" \
		-e "s:temppath=tmp:temppath=/var/entropy/tmp:g" \
		entropy.conf-dist > entropy.conf
	insinto /var/entropy
	doins entropy.conf seed.txt

	dodoc README TODO entropy.conf-dist seed.txt-dist
	dohtml ENTROPY.html
	use mysql && dodoc README.MySQL
}

pkg_preinst() {
	enewgroup entropy
	enewuser entropy -1 -1 /var/entropy entropy
}
