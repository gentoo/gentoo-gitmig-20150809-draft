# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.3.5-r1.ebuild,v 1.7 2009/05/31 11:05:13 scarabeus Exp $

EAPI="1"
WANT_AUTOMAKE=1.9

inherit autotools eutils kde-functions multilib

DESCRIPTION="ICQ Client with v8 support"
HOMEPAGE="http://www.licq.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE="ssl socks5 qt3 kde ncurses crypt msn debug"

# we can't have conditional dependencies so "use kde && inherit kde"
# won't work -- messes up dep caching.

# need-kde and their eclass friends inject things into DEPEND. But we only
# want them enabled if the kde USE flag is set. We get around this in the
# following dep lines:
RDEPEND="kde? ( >=kde-base/kdelibs-3.0:3.5 )"
DEPEND="kde? ( >=kde-base/kdelibs-3.0:3.5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	qt3? ( =x11-libs/qt-3* )
	ncurses? ( sys-libs/ncurses >=dev-libs/cdk-4.9.11.20031210-r1 )
	crypt? ( >=app-crypt/gpgme-1.0.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-logonfix.patch
	epatch "${FILESDIR}"/${P}-prevent-dos.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch

	use ncurses && epatch "${FILESDIR}"/1.3.0-suse_bool.patch

	if use kde
	then
		# fix for #12436
		ebegin "Setting kde plugin as default"
		cp "${S}"/src/licq.conf.h "${T}"
		sed "s:Plugin1 = qt-gui:Plugin1 = kde-gui:" \
			"${T}"/licq.conf.h > "${S}"/src/licq.conf.h
		eend $?
	else
		if ! use qt3
		then
			ebegin "Setting console plugin as default..."
			cp "${S}"/src/licq.conf.h "${T}"
			sed "s:Plugin1 = qt-gui:Plugin1 = console:" \
				"${T}"/licq.conf.h > "${S}"/src/licq.conf.h
			eend $?
		fi
	fi

	# Install plugins in the correct libdir
	sed -i -e "s:lib/licq/:$(get_libdir)/licq/:" \
		"${S}"/include/licq_constants.h || die "sed failed"
	sed -i -e 's:$(prefix)/lib:@libdir@:' \
		"${S}"/plugins/*/src/Makefile.{in,am} || die "sed failed"

	#Autoconf >=2.62 and libtool >2 requires this. Sigh.
	rm -f $(find . -name 'acinclude.m4')
	cp admin/acinclude.m4{.in,}
	cp acinclude.m4{.in,}
	AT_M4DIR="admin" eautoreconf

	AT_M4DIR="../../admin"
	for plugin in auto-reply console email msn rms; do
		cd "${S}"/plugins/${plugin}
		cp acinclude.m4{.in,} || die "acinclude not found"
		eautoreconf
	done
	cd "${S}"/plugins/qt-gui
	cp acinclude.m4{.in,} || die "acinclude not found"
	eaclocal
	eautomake
	perl am_edit {src/,share/,po/}Makefile.in
	eautoconf
}

src_compile() {
	local myconf
	use ssl     || myconf="${myconf} --disable-openssl"
	use socks5  && myconf="${myconf} --enable-socks5"
	use debug   && myconf="${myconf} --enable-debug"

	myconf="${myconf} $(use_enable crypt gpgme)"

	cd "${S}"

	# bug #21009
	find . -name 'configure' -exec sed -e "s:sed 's/-g:sed 's/^-g:" -i {} \;

	econf ${myconf} || die "econf failed"

	use crypt && {
		# workaround for gpgme's headers inclusion path
		sed \
			-e "s:FAULT_INCLUDES =:FAULT_INCLUDES = -I/usr/include/gpgme:" \
			-i "${S}"/src/Makefile
	}

	emake || die "emake failed"

	# Create the various plug-ins

	# First, the Qt plug-in
	if use qt3
	then
		set-qtdir 3
		set-kdedir 3

		use kde && myconf="${myconf} --with-kde"

		# Problems finding qt on multilib systems
		myconf="${myconf} --with-qt-libraries=${QTDIR}/$(get_libdir)"

		# note! watch the --prefix=/usr placement;
		# licq itself installs into /usr, but the
		# optional kde/qt interface (to which second_conf belogns)
		# installs its files in $KDE3DIR/{lib,share}/licq

		cd "${S}"/plugins/qt-gui
		einfo "Compiling Qt GUI plug-in"
		econf ${myconf} || die
		emake || die
	fi

	# Now the console plug-in
	if use ncurses
	then
		cd "${S}"/plugins/console
		einfo "Compiling the Console plug-in"
		econf || die
		emake || die
	fi

	for plugin in auto-reply rms msn email ; do
		cd "${S}"/plugins/${plugin}
		einfo "Compiling '${plugin}' plug-in"
		econf || die "econf failed for ${plugin} plugin"
		emake || die "emake failed for ${plugin} plugin"
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog INSTALL README* doc/*

	# Install the plug-ins
	if use qt3
	then
		cd "${S}"/plugins/qt-gui
		emake DESTDIR="${D}" install || die
		docinto plugins/qt-gui
		dodoc README*

	fi

	if use ncurses
	then
		cd "${S}"/plugins/console
		emake DESTDIR="${D}" install || die
		docinto plugins/console
		dodoc README
	fi

	if use msn
	then
		cd "${S}"/plugins/msn
		make DESTDIR="${D}" install || die
		docinto plugins/msn
		dodoc README
	fi

	cd "${S}"/plugins/auto-reply
	emake DESTDIR="${D}" install || die
	docinto plugins/auto-reply
	dodoc README licq_autoreply.conf

	cd "${S}"/plugins/rms
	make DESTDIR="${D}" install || die
	docinto plugins/rms
	dodoc README licq_rms.conf

	exeinto /usr/share/${PN}/upgrade
	doexe "${S}"/upgrade/*

	# fixes bug #22136 and #149464
	rm -fR "${D}"/var
}

pkg_postinst() {
	echo
	ewarn
	ewarn "If you're upgrading from <=licq-1.3.0 - you have to manually "
	ewarn "upgrade your existing licq installation. Please backup your "
	ewarn "settings and look into: /usr/share/licq/upgrade for scripts."
	ewarn
	echo
}
