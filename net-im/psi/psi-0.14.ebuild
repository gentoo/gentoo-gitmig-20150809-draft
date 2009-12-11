# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.14.ebuild,v 1.3 2009/12/11 07:12:01 jer Exp $

EAPI="2"

inherit eutils qt4 multilib

MY_P="${P/_rc/-rc}"

DESCRIPTION="Qt4 Jabber client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
# Langpack:
# http://lists.affinix.com/pipermail/psi-devel-affinix.com/2009-August/008798.html
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	mirror://gentoo/${PN}-0.13-20090817_langpack_for_packagers.zip
	extras? ( mirror://gentoo/${PN}-extra-patches-r1428.tar.bz2
		mirror://gentoo/${PN}-extra-iconsets-r1428.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE="crypt dbus debug doc extras jingle spell ssl xscreensaver webkit"
RESTRICT="test"

LANGS="de es fr it mk pl pt_BR ru sv ur_PK zh_TW"
for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
	#SRC_URI="${SRC_URI} http://psi-im.org/download/lang/psi_${LNG/ur_PK/ur_pk}.qm"
done

RDEPEND=">=x11-libs/qt-gui-4.4:4[qt3support,dbus?]
	>=app-crypt/qca-2.0.2:2
	spell? ( >=app-text/enchant-1.3.0 )
	xscreensaver? ( x11-libs/libXScrnSaver )
	extras? ( webkit? ( x11-libs/qt-webkit ) )
	app-arch/unzip"

DEPEND="${RDEPEND}
	extras? ( sys-devel/qconf )
	doc? ( app-doc/doxygen )"

PDEPEND="crypt? ( app-crypt/qca-gnupg:2 )
	jingle? ( net-im/psimedia )
	ssl? ( app-crypt/qca-ossl:2 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
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

		echo "		755-psiplus-fix-application-info-defines.diff
		9999-psiplus-application-info.diff"

		EPATCH_EXCLUDE="${MY_EPATCH_EXCLUDE}
			755-psiplus-fix-application-info-defines.diff
			9999-psiplus-application-info.diff" \
		EPATCH_SUFFIX="diff" EPATCH_FORCE="yes" epatch
		sed -e 's/\(^#define PROG_CAPS_NODE	\).*/\1"http:\/\/psi-dev.googlecode.com\/caps";/' \
			-e 's:\(^#define PROG_NAME "Psi\):\1+:' \
				-i src/applicationinfo.cpp || die

		qconf || die "Failed to create ./configure."
	else
		if use webkit; then
			ewarn "Webkit support disabled as it is only availalable in Psi+"
			ewarn "(USE='extras' enabled)."
		fi
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
			$(use spell || echo '--disable-enchant')
			$(use xscreensaver || echo '--disable-xss')
			$(use extras && { use webkit || echo '--enable-qtwebkit';} )"

	echo ${confcmd}
	${confcmd} || die "configure failed"
	# Makefile is not always created...
	[[ ! -f Makefile ]] && die "configure failed"
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
