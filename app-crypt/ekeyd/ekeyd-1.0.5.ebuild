# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ekeyd/ekeyd-1.0.5.ebuild,v 1.1 2009/09/28 10:59:06 flameeyes Exp $

EAPI=2

inherit multilib

DESCRIPTION="Entropy Key userspace daemon"
HOMEPAGE="http://www.entropykey.co.uk/"
SRC_URI="http://www.entropykey.co.uk/res/download/${P}.tar.gz"

LICENSE="as-is" # yes, truly

SLOT="0"

KEYWORDS="~amd64"

IUSE="usb kernel_linux"

RDEPEND="dev-lang/lua
	usb? ( dev-libs/libusb:0 )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	dev-libs/luasocket
	kernel_linux? ( sys-fs/udev )"

src_prepare() {
	# - avoid using -Werror;
	# - don't gzip the man pages, this will also stop it from
	#   installing them, so we'll do it by hand.
	sed -i \
		-e 's:-Werror::' \
		-e '/gzip/d' \
		daemon/Makefile || die
}

src_compile() {
	local osname

	# Override automatic detection: upstream provides this with uname,
	# we don't like using uname.
	case ${CHOST} in
		*-linux-*)
			osname=linux;;
		*-freebsd*)
			osname=freebsd;;
		*-kfrebsd-gnu)
			osname=gnukfreebsd;;
		*-openbsd*)
			osname=openbsd;;
		*)
			die "Unsupported operating system!"
			;;
	esac

	# We don't slot LUA so we don't really need to have the variables
	# set at all.
	emake -C daemon \
		LUA_V= LUA_INC= \
		OSNAME=${osname} \
		OPT="${CFLAGS}" \
		BUILD_ULUSBD=$(use usb && echo yes || echo no) \
		|| die "emake failed"
}

src_install() {
	emake -C daemon \
		DESTDIR="${D}" \
		install || die "emake install failed"

	# Install them manually because we don't want them gzipped
	doman daemon/{ekeyd,ekey-setkey,ekey-rekey,ekeydctl}.8 \
		daemon/ekeyd.conf.5 || die

	if use usb; then
		doman daemon/ekey-ulusbd.8 || die
	fi

	dodoc daemon/README* AUTHORS WARNING || die

	if use kernel_linux; then
		insinto /etc/udev/rules.d
		newins doc/60-UDEKEY01.rules 70-${PN}.rules || die

		exeinto /$(get_libdir)/udev
		doexe doc/ekeyd-udev || die
	fi

	keepdir /etc/ekeyd

	newinitd "${FILESDIR}"/${PN}.init ${PN} || die
}

pkg_postinst() {
	elog "To make use of your entropykey, make sure to execute ekey-rekey"
	elog "the first time, and then start the ekeyd service."
	elog ""
	elog "The service supports multiplexing if you wish to use multiple"
	elog "keys, just symlink /etc/init.d/ekeyd → /etc/init.d/ekeyd.identifier"
	elog "and it'll be looking for /etc/init.d/identifier.conf"

	if use usb; then
		elog ""
		elog "TODO TODO TODO TODO TODO"
		elog ""
		elog "Please note that while the userland USB daemon is being built"
		elog "there currently is no init script to start it; this will be fixed"
		elog "as soon as possible."
		elog ""
		elog "TODO TODO TODO TODO TODO"
	fi
}
