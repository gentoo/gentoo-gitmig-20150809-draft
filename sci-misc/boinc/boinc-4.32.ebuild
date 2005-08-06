# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/boinc/boinc-4.32.ebuild,v 1.4 2005/08/06 11:53:21 hansmi Exp $

inherit eutils

MY_PN="boinc_public-cvs"
MY_PV="2005-04-17"
S=${WORKDIR}/boinc_public

DESCRIPTION="The Berkeley Open Infrastructure for Network Computing"
HOMEPAGE="http://boinc.ssl.berkeley.edu/"
SRC_URI="http://boinc.ssl.berkeley.edu/source/nightly/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="server X"

DEPEND=">=sys-devel/gcc-3.0.4
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.9.3
	X? ( virtual/x11
	virtual/glut
	virtual/glu
	>=x11-libs/wxGTK-2.4.2-r2 )
	server? ( >=dev-db/mysql-4.0.24
	>=dev-php/php-4.3.10
	>=dev-lang/python-2.2.3 )"
RDEPEND=" X? ( virtual/x11
	virtual/glut
	virtual/glu
	>=x11-libs/wxGTK-2.4.2-r2 )
	server? ( net-www/apache
	>=dev-db/mysql-4.0.24
	>=dev-php/php-4.3.10
	>=dev-lang/python-2.2.3
	dev-python/mysql-python )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# point to a proper mouse device
	sed -i "s:/dev/mouse:/dev/psaux:g" client/hostinfo_unix.C

	epatch ${FILESDIR}/${P}_cmdline_options.patch
	epatch ${FILESDIR}/${P}_socket_close_fix.patch
}

src_compile() {
	# boinc does not support unicode so force wxconfig non-unicode
	WXCONFIG=$(ls /usr/bin/wxgtk2-?.?-config)
	if [ -e "${WXCONFIG}" ]; then
		CONF="--with-wx-config=${WXCONFIG}"
	fi

	econf --enable-client \
	`use_enable server` \
	`use_with X x` \
	${CONF} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
#	einstall || die "install failed"
	make install DESTDIR=${D} || die "make install failed"

	newinitd ${FILESDIR}/boinc.init boinc
	newconfd ${FILESDIR}/boinc.conf boinc
}

pkg_preinst() {
	enewgroup boinc
	enewuser boinc -1 /bin/false /var/lib/boinc boinc
}

pkg_postinst() {
	echo
	einfo "You need to attach to a project to do anything useful with boinc."
	einfo "You can do this by running /etc/init.d/boinc attach"
	einfo "BOINC The howto for configuration is located at:"
	einfo "http://boinc.berkeley.edu/anonymous_platform.php"
	if use server;then
		einfo "You have chosen to enable server mode. this ebuild has installed"
		einfo "the necessary packages to be a server, you will need to have a"
		einfo "project. Contact BOINC directly for further information."
	fi
	echo
}
