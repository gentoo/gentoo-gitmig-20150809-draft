# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/entropy_rsa/entropy_rsa-0.9.1.439.ebuild,v 1.2 2005/10/25 04:14:10 flameeyes Exp $

inherit eutils

MY_PV_BUILD=${PV##*.}
MY_PV=${PV%.*}
DESCRIPTION="A p2p-node to share your files, infos, philosophy ... anonymously"
HOMEPAGE="http://entropy.stop1984.com/"
SRC_URI="http://entropy.stop1984.com/files/entropy_rsa-${MY_PV}-${MY_PV_BUILD}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql"

DEPEND="mysql? ( dev-db/mysql )"
RDEPEND="${DEPEND}
	app-admin/sudo"

S=${WORKDIR}/${PN}-${MY_PV}

pkg_setup() {
	enewgroup entropy
	enewuser entropy -1 -1 /var/entropy entropy
}

src_compile() {
	[[ $(gcc-major-version) == "4" ]] && die "Sorry, entropy must be compiled with gcc-3.x"

	local myconf=""
	use mysql \
		&& myconf="--with-mysql=/usr" \
		|| myconf="--with-tree"
	econf ${myconf} || die
	emake || die
}

src_install() {
	dobin entropy_rsa monoopt storechg || die
	dodoc README TODO CODINGRULES entropy_rsa.conf-dist seed.txt-dist
	dohtml ENTROPY.html
	use mysql && dodoc README.MySQL

	newinitd "${FILESDIR}"/entropy_rsa.rc entropy_rsa
	local STORE_TYPE="tree"
	use mysql && STORE_TYPE="mysql"
	echo "ENTROPY_USER=entropy" > entropy_rsa.conf.d
	echo "STORE_TYPE=${STORE_TYPE}" >> entropy_rsa.conf.d
	newconfd entropy_rsa.conf.d entropy_rsa

	diropts -o entropy -g entropy
	insopts -o entropy -g entropy -m0644
	dodir /var/entropy/{de,chat,node,store,tmp}
	insinto /var/entropy
	doins -r de node chat || die

	# setup config file
	sed -e "3,$ s:#::g" seed.txt-dist > seed.txt
	sed \
		-e "s:seednodes=seed.txt:seednodes=/var/entropy/seed.txt:g" \
		-e "s:logfile=./entropy_rsa.log:logfile=/var/entropy/entropy_rsa.log:g" \
		-e "s:storepath=store:storepath=/var/entropy/store:g" \
		-e "s:temppath=tmp:temppath=/var/entropy/tmp:g" \
		-e "s:runpath=:runpath=/var/entropy/:g" \
		entropy_rsa.conf-dist > entropy_rsa.conf
	use mysql && cat "${FILESDIR}"/mysql.conf >> entropy_rsa.conf
	insinto /etc
	doins entropy_rsa.conf
	dosym /etc/entropy_rsa.conf /var/entropy/entropy_rsa.conf

	insinto /var/entropy
	doins ${CONFIG} seed.txt
}
