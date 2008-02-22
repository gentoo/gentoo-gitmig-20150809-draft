# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpwatch/tmpwatch-2.9.12.2.ebuild,v 1.3 2008/02/22 06:52:11 opfer Exp $

inherit rpm versionator

RPM_P="${PN}-$(replace_version_separator 3 '-')"
MY_P="${RPM_P%-*}"

DESCRIPTION="Files which haven't been accessed in a given period of time are removed from specified directories"
HOMEPAGE="http://download.fedora.redhat.com/pub/fedora/linux/development/source/SRPMS/"
SRC_URI="http://download.fedora.redhat.com/pub/fedora/linux/development/source/SRPMS/${RPM_P}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	rpm_src_unpack

	cd "${S}"
	sed -i -e "s:..RPM_OPT_FLAGS.:${CFLAGS}:" \
		-e "s:^CVS:#CVS:g" Makefile \
		|| die "sed Makefile failed"
	sed -i 's|/sbin/fuser|/bin/fuser|' tmpwatch.c \
		|| die "sed tmpwatch.c failed"
	sed -i 's|/sbin|/bin|' tmpwatch.8 || die "sed tmpwatch.8 failed"
}

src_install() {
	dosbin tmpwatch || die "dosbin failed"
	doman tmpwatch.8 || die "doman failed"

	exeinto /etc/cron.daily
	newexe "${FILESDIR}/${PN}.cron" "${PN}" || die 'failed to install cron'
}
