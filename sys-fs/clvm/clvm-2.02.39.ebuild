# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/clvm-2.02.39.ebuild,v 1.2 2008/11/21 23:33:15 xmerlin Exp $

inherit eutils multilib

MY_P="${PN/clvm/LVM2}.${PV}"

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="readline static selinux"

DEPEND=">=sys-fs/device-mapper-1.02.27
	=sys-cluster/dlm-2*
	=sys-cluster/cman-2*
	"

RDEPEND="${DEPEND}
	!sys-fs/lvm-user
	!sys-fs/lvm2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/lvm.conf-2.02.33.patch || die
	#epatch "${FILESDIR}"/cluster-locking-built-in.patch || die
}

src_compile() {
	# Static compile of lvm2 so that the install described in the handbook works
	# http://www.gentoo.org/doc/en/lvm2.xml
	# fixes http://bugs.gentoo.org/show_bug.cgi?id=84463
	local myconf
	local buildmode

	# fsadm is broken, don't include it (2.02.28)
	myconf="${myconf} --enable-dmeventd --enable-cmdlib"

	# Most of this package does weird stuff.
	# The build options are tristate, and --without is NOT supported
	# options: 'none', 'internal', 'shared'
	if use static ; then
		einfo "Building static LVM, for usage inside genkernel"
		myconf="${myconf} --enable-static_link"
		buildmode="internal"
	else
		ewarn "Building shared LVM, it will not work inside genkernel!"
		buildmode="shared"
	fi

	# dmeventd requires mirrors to be internal, and snapshot available
	# so we cannot disable them
	myconf="${myconf} --with-mirrors=internal"
	myconf="${myconf} --with-snapshots=internal"

	if use lvm1 ; then
		myconf="${myconf} --with-lvm1=${buildmode}"
	else
		myconf="${myconf} --with-lvm1=none"
	fi

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	myconf="${myconf} --with-cluster=${buildmode}"
	# 4-state!
	myconf="${myconf} --with-clvmd=cman"
	myconf="${myconf} --with-pool=${buildmode}"

	myconf="${myconf} --sbindir=/sbin --with-staticdir=/sbin"
	econf $(use_enable readline) \
		$(use_enable selinux) \
		--libdir=/usr/$(get_libdir) \
		${myconf} \
		CLDFLAGS="${LDFLAGS}" || die
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install

	# TODO: At some point in the future, we need to stop installing the static
	# as the /sbin/lvm name, and have both variants seperate.
	if use static; then
		cp -f "${D}"/sbin/lvm.static "${D}"/sbin/lvm \
			|| die "Failed to copy lvm.static"
	fi

	dodir /$(get_libdir)
	# Put these in root so we can reach before /usr is up
	for i in libdevmapper-event-lvm2mirror liblvm2{format1,snapshot} ; do
		b="${D}"/usr/$(get_libdir)/${i}
		if [ -f "${b}".so ]; then
			mv -f "${b}".so* "${D}"/$(get_libdir) || die
		fi
	done

	dodoc README VERSION WHATS_NEW doc/*.{conf,c,txt}
	insinto /lib/rcscripts/addons
	newins "${FILESDIR}"/lvm2-start.sh lvm-start.sh || die
	newins "${FILESDIR}"/lvm2-stop.sh lvm-stop.sh || die

	newinitd "${FILESDIR}"/lvm.rc lvm || die
	newconfd "${FILESDIR}"/lvm.confd lvm || die

	newinitd "${FILESDIR}"/clvmd.rc clvmd || die
	newconfd "${FILESDIR}"/clvmd.confd clvmd || die

	elog ""
	elog "Rebuild your genkernel initramfs if you are using lvm"
	use nolvmstatic && \
		elog "USE=nolvmstatic has changed to USE=static via package.use"
}

pkg_postinst() {
	elog "lvm volumes are no longer automatically created for"
	elog "baselayout-2 users. If you are using baselayout-2, be sure to"
	elog "run: # rc-update add lvm boot"
}
