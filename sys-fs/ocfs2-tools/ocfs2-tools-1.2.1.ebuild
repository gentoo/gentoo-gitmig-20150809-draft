# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ocfs2-tools/ocfs2-tools-1.2.1.ebuild,v 1.3 2007/06/26 02:53:50 mr_bones_ Exp $

PV_MAJOR="${PV%%.*}"
PV_MINOR="${PV#*.}"
PV_MINOR="${PV_MINOR%%.*}"
DESCRIPTION="Support programs for the Oracle Cluster Filesystem 2"
HOMEPAGE="http://oss.oracle.com/projects/ocfs2-tools/"
SRC_URI="http://oss.oracle.com/projects/ocfs2-tools/dist/files/source/v${PV_MAJOR}.${PV_MINOR}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
# (#142216) build system's broke, always requires glib for debugfs utility
RDEPEND="X? (
		=x11-libs/gtk+-2*
		>=dev-lang/python-2
		>=dev-python/pygtk-2
	)
	>=dev-libs/glib-2.2.3
	sys-fs/e2fsprogs"
DEPEND="${RDEPEND}"

src_compile() {
	local myconf="--enable-dynamic-fsck --enable-dynamic-ctl"

	econf --prefix=${ROOT} \
		$(use_enable X ocfs2console) \
		${myconf} \
		|| die "Failed to configure"

	emake -j1 || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "Failed to install"

	doman \
		mkfs.ocfs2/mkfs.ocfs2.8 \
		ocfs2cdsl/ocfs2cdsl.8 \
		ocfs2console/ocfs2console.8 \
		ocfs2_hb_ctl/ocfs2_hb_ctl.8 \
		tunefs.ocfs2/tunefs.ocfs2.8
	dodoc \
		COPYING CREDITS MAINTAINERS README README.O2CB debugfs.ocfs2/README \
		documentation/users_guide.txt documentation/samples/cluster.conf \
		"${FILESDIR}"/INSTALL.GENTOO

	# Keep o2cb script in case someone needs it
	insinto /usr/sbin
	newins "${S}"/vendor/common/o2cb.init o2cb
	insinto /etc/default
	newins "${S}"/vendor/common/o2cb.sysconfig o2cb

	# Move programs not needed before /usr is mounted to /usr/sbin/
	mv "${D}"/sbin/ocfs2cdsl "${D}"/usr/sbin/
	mv "${D}"/sbin/ocfs2console "${D}"/usr/sbin/

	newinitd "${FILESDIR}"/ocfs2.init ocfs2
	newconfd "${FILESDIR}"/ocfs2.conf ocfs2

	insinto /etc/ocfs2
	newins "${S}"/documentation/samples/cluster.conf cluster.conf

	keepdir /config
	keepdir /dlm

	# FIXME - fix the python lib.
	# pythonians wouldn't like this probably, but I couldn't find better
	# solution.
	mv "${D}"/lib "${D}"/usr
}

pkg_postinst() {
	elog "Read ${ROOT}usr/share/doc/${P}/INSTALL.GENTOO.gz for instructions"
	elog "about how to install, configure and run ocfs2."
}
