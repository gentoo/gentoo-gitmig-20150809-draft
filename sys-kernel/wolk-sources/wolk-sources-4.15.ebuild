# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.15.ebuild,v 1.3 2004/11/03 06:56:46 psi29a Exp $

# Ramereth's contributed WOLK ebuild - thanks! (you didn't think you'd
# go blameless, did you?)

UNIPATCH_LIST="${DISTDIR}/${WOLK_SRC} ${FILESDIR}/binfmt_elf.patch"
UNIPATCH_STRICTORDER="yes"

OKV="2.4.20"
OKB="2.4"
EXTRAVERSION="-${PN%-*}-${PV/$OKV./}"
KV="${OKV}${EXTRAVERSION}"
S="${WORKDIR}/linux-${KV}"
WOLK_SRC="linux-${OKV}-wolk${PV/${OKV}./}s.patch.bz2"

ETYPE="sources"
inherit kernel-2
# detect_version doesn't work for WOLK yet -- don't use it!

KEYWORDS="~x86 -mips"

K_NOSETEXTRAVERSION="don't_set_it"
RESTRICT="nomirror"
DESCRIPTION=" Marc-Christian Peterson's WOLK kernel. A stable and development kernel, containing many useful patches from many projects."
SRC_URI="mirror://kernel/linux/kernel/${OKB}/linux-${OKV}.tar.bz2 mirror://kernel/linux/kernel/people/mcp/${OKB}-WOLK/${WOLK_SRC}"

K_EXTRAEINFO="If there are issues with this kernel, search http://bugs.gentoo.org/ for an
existing bug. Only create a new bug if you have not found one that matches
your issue. It is best to do an advanced search as the initial search has a
very low yield. Please assign your bugs to x86-kernel@gentoo.org.
Please read the ChangeLog and associated docs for more information."
