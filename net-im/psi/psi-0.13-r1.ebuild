# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.13-r1.ebuild,v 1.7 2009/11/23 21:20:06 maekke Exp $

EAPI="2"

inherit eutils qt4 multilib

MY_P="${P/_rc/-rc}"

DESCRIPTION="Qt4 Jabber client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
# Langpack:
# http://lists.affinix.com/pipermail/psi-devel-affinix.com/2009-August/008798.html
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	mirror://gentoo/${P}-20090817_langpack_for_packagers.zip
	extras? ( mirror://gentoo/${PN}-extra-patches-r927.tar.bz2
		mirror://gentoo/${PN}-extra-iconsets-r927.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86 ~x86-fbsd"
IUSE="crypt dbus debug doc extras jingle spell ssl xscreensaver"
RESTRICT="test"

LANGS="de es fr it mk pl pt_BR ru sv ur_PK zh_TW"
for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
	#SRC_URI="${SRC_URI} http://psi-im.org/download/lang/psi_${LNG/ur_PK/ur_pk}.qm"
done

RDEPEND=">=x11-libs/qt-gui-4.4:4[qt3support,dbus?]
	>=app-crypt/qca-2.0.2:2
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )
	app-arch/unzip"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

PDEPEND="crypt? ( app-crypt/qca-gnupg:2 )
	jingle? ( net-im/psimedia )
	ssl? ( app-crypt/qca-ossl:2 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/psi-0.13-psi+muc-kickban-reasons.patch"
	epatch "${FILESDIR}/psi-0.13-psi+options-coloring-in-chat-dialog.patch"

	if use extras; then
		# some patches from psi+ project http://code.google.com/p/psi-dev
		ewarn "You're about to build heavily patched version of Psi called Psi+."
		ewarn "It has really nice features but still is under heavy development."
		ewarn "Take a look at homepage for more info: http://code.google.com/p/psi-dev"
		ewarn "If you wish to disable some patches just put"
		ewarn "MY_EPATCH_EXCLUDE=\"list of patches\""
		ewarn "into /etc/portage/env/${CATEGORY}/${PN} file."
		ewarn
		ewarn "Note: some patches depend on other. So if you disabled some patch"
		ewarn "and other started to fail to apply, you'll have to disable patches"
		ewarn "that fail too."
		ebeep

		EPATCH_EXCLUDE="${MY_EPATCH_EXCLUDE} 270-psi-application-info.diff" \
		EPATCH_SUFFIX="diff" EPATCH_FORCE="yes" epatch
		sed -e 's/\(^#define PROG_CAPS_NODE	\).*/\1"http:\/\/psi-dev.googlecode.com\/caps";/' \
			-e 's:\(^#define PROG_NAME "Psi\):\1+:' \
				-i src/applicationinfo.cpp || die
	fi

	rm -rf third-party/qca # We use system libraries.
}

src_configure() {
	# unable to use econf because of non-standard configure script
	# disable growl as it is a MacOS X extension only
	local confcmd="./configure
			--prefix=/usr
			--qtdir=/usr
			--disable-bundled-qca
			--disable-growl
			$(use dbus || echo '--disable-qdbus')
			$(use debug && echo '--enable-debug')
			$(use spell || echo '--disable-aspell')
			$(use xscreensaver || echo '--disable-xss')"

	echo ${confcmd}
	${confcmd} || die "configure failed"
}

src_compile() {
	eqmake4

	emake || die "emake failed"

	if use doc; then
		cd doc
		mkdir -p api # 259632
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	rm "${D}"/usr/share/psi/{COPYING,README}

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster || die
	newdoc iconsets/system/README README.system || die
	newdoc certs/README README.certs || die
	dodoc README || die

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi

	# install translations
	cd "${WORKDIR}"
	insinto /usr/share/${PN}/
	for LNG in ${LANGS}; do
		if use linguas_${LNG}; then
			doins ${LNG}/${PN}_${LNG}.qm || die
		fi
	done

	if use extras; then
		cp -a "${WORKDIR}"/iconsets/* "${D}"/usr/share/${PN}/iconsets/ || die
	fi
}
