# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vim.eclass,v 1.104 2005/03/24 16:36:32 ciaranm Exp $

# Authors:
# 	Ryan Phillips <rphillips@gentoo.org>
# 	Seemant Kulleen <seemant@gentoo.org>
# 	Aron Griffis <agriffis@gentoo.org>
# 	Ciaran McCreesh <ciaranm@gentoo.org>

# This eclass handles vim, gvim and vim-core.  Support for -cvs ebuilds is
# included in the eclass, since it's rather easy to do, but there are no
# official vim*-cvs ebuilds in the tree.

# gvim's GUI preference order is as follows:
# aqua                          CARBON (not tested, 7+)
# -aqua gtk gtk2 gnome          GNOME2 (6.3-r1+, earlier uses GTK2)
# -aqua gtk gtk2 -gnome         GTK2
# -aqua gtk -gtk2 gnome         GNOME1
# -aqua gtk -gtk2 -gnome        GTK1
# -aqua -gtk qt                 QT (7+)
# -aqua -gtk -qt motif          MOTIF
# -aqua -gtk -motif nextaw      NEXTAW (7+)
# -aqua -gtk -motif -nextaw     ATHENA

inherit eutils vim-doc flag-o-matic versionator fdo-mime

# Support -cvs ebuilds, even though they're not in the official tree.
MY_PN="${PN%-cvs}"

# This isn't a conditional inherit from portage's perspective, since $MY_PN is
# constant at cache creation time. It's therefore legal and doesn't break
# anything. I even checked with carpaski first :) (08 Sep 2004 ciaranm)
if [[ "${MY_PN}" != "vim-core" ]] ; then
	inherit debug
fi

if [[ "${PN##*-}" == "cvs" ]] ; then
	inherit cvs
fi

if [[ $(get_major_version ) -ge 7 ]] ; then
	inherit bash-completion
fi

ECLASS=vim
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_unpack pkg_setup

IUSE="$IUSE selinux ncurses nls acl"

if [[ "${MY_PN}" == "vim-core" ]] ; then
	IUSE="$IUSE livecd"
else
	IUSE="$IUSE cscope gpm perl python ruby"
	DEPEND="$DEPEND
		cscope?  ( dev-util/cscope )
		gpm?     ( >=sys-libs/gpm-1.19.3 )
		perl?    ( dev-lang/perl )
		python?  ( dev-lang/python )
		selinux? ( sys-libs/libselinux )
		acl?     ( sys-apps/acl )
		ruby?    ( virtual/ruby )"
	RDEPEND="$RDEPEND
		cscope?  ( dev-util/cscope )
		gpm?     ( >=sys-libs/gpm-1.19.3 )
		perl?    ( dev-lang/perl )
		python?  ( dev-lang/python )
		selinux? ( sys-libs/libselinux )
		acl?     ( sys-apps/acl )
		ruby?    ( virtual/ruby )"

	if [[ "${MY_PN}" == "vim" ]] ; then
		IUSE="$IUSE vim-with-x minimal"
		DEPEND="$DEPEND vim-with-x? ( virtual/x11 )"
		RDEPEND="$RDEPEND vim-with-x? ( virtual/x11 )"
	elif [[ "${MY_PN}" == "gvim" ]] ; then
		IUSE="$IUSE gnome gtk gtk2 motif"
	fi
fi

# vim7 has some extra options. tcltk is working again, and mzscheme support
# has been added. netbeans now has its own USE flag, but it's only available
# under gvim. We have a few new GUI toolkits, and we can also install a
# vimpager (this is in vim6 as well, but the ebuilds don't handle it). There
# is now a spellchecker too.
if [[ $(get_major_version ) -ge 7 ]] ; then
	IUSE="${IUSE} spell"

	if [[ "${MY_PN}" != "vim-core" ]] ; then
		IUSE="${IUSE} tcltk mzscheme"
		DEPEND="$DEPEND
			tcltk?    ( dev-lang/tcl )
			mzscheme? ( dev-lisp/mzscheme )"
		RDEPEND="$RDEPEND
			tcltk?    ( dev-lang/tcl )
			mzscheme? ( dev-lisp/mzscheme )"
	fi
	if [[ "${MY_PN}" == "gvim" ]] ; then
		IUSE="$IUSE netbeans aqua nextaw qt"
		DEPEND="$DEPEND   netbeans? ( dev-util/netbeans )"
		RDEPEND="$RDEPEND netbeans? ( dev-util/netbeans )"
	fi
	if [[ "${MY_PN}" == "vim" ]] ; then
		IUSE="$IUSE vim-pager"
	fi

	# app-vim blocks
	if [[ "${MY_PN}" != "vim-core" ]] ; then
		# align: bug 79982
		RDEPEND="${RDEPEND}
			!<app-vim/align-30-r1
			!app-vim/latexsuite
			!app-vim/vimspell"
	fi
fi

HOMEPAGE="http://www.vim.org/"
SLOT="0"
LICENSE="vim"

# Portage dependancy is for use_with/use_enable.
# ctags dependancy allows help tags to be rebuilt properly, along
# with detection of exuberant-ctags by configure.
DEPEND="$DEPEND 
	>=sys-apps/portage-2.0.45-r3
	>=sys-apps/sed-4
	sys-devel/autoconf
	ncurses?  ( >=sys-libs/ncurses-5.2-r2 )
	!ncurses? ( sys-libs/libtermcap-compat )
	dev-util/ctags
	"
RDEPEND="$RDEPEND 
	ncurses?  ( >=sys-libs/ncurses-5.2-r2 )
	!ncurses? ( sys-libs/libtermcap-compat )
	dev-util/ctags
	"

apply_vim_patches() {
	local p
	cd ${S} || die "cd ${S} failed"

	# Scan the patches, applying them only to files that either
	# already exist or that will be created by the patch
	#
	# Changed awk to gawk in the below; BSD's awk chokes on it
	# --spb, 2004/12/18
	einfo "Filtering vim patches ..."
	p=${WORKDIR}/${VIM_ORG_PATCHES%.tar*}.patch
	ls ${WORKDIR}/vimpatches | sort | \
	while read f; do gzip -dc ${WORKDIR}/vimpatches/${f}; done | gawk '
		/^Subject: Patch/ {
			if (patchnum) {printf "\n" >"/dev/stderr"}
			patchnum = $3
			printf "%s:", patchnum >"/dev/stderr"
		}
		$1=="***" && $(NF-1)~/^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]$/ {
			# First line of a patch; suppress printing
			firstlines = $0
			next
		}
		$1=="---" && $(NF-1)~/^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]$/ {
			# Second line of a patch; try to open the file to see
			# if it exists.
			thisfile = $2
			if (!seen[thisfile] && (getline tryme < thisfile) == -1) {
				# Check if it will be created
				firstlines = firstlines "\n" $0
				getline
				firstlines = firstlines "\n" $0
				getline
				if ($0 != "*** 0 ****") {
					# Non-existent and not created, stop printing
					printing = 0
					printf " (%s)", thisfile >"/dev/stderr"
					next
				}
			}
			# Print the previous lines and start printing
			print firstlines
			printing = 1
			printf " %s", thisfile >"/dev/stderr"
			# Remember that we have seen this file
			seen[thisfile] = 1
		}
		printing { print }
		END { if (patchnum) {printf "\n" >"/dev/stderr"} }
		' > ${p} || die

	# For reasons yet unknown, epatch fails to apply this cleanly
	ebegin "Applying filtered vim patches ..."
	TMPDIR=${T} patch -f -s -p0 < ${p}
	eend 0
}

vim_pkg_setup() {
	if ! version_is_at_least "6.3-r2" ; then
		eerror "${PF} is no longer supported by vim.eclass. Maybe you need to"
		eerror "re-run 'emerge sync', or maybe you need to check your overlay"
		eerror "and /etc/portage/package.* files."
		die "${PF} not supported."
	fi

	# people with broken alphabets run into trouble. bug 82186.
	unset LANG LC_ALL
}

vim_src_unpack() {
	unpack ${A}

	if [[ "${PN##*-}" == "cvs" ]] ; then
		ECVS_SERVER="cvs.sourceforge.net:/cvsroot/vim"
		ECVS_PASS=""
		if [[ $(get_major_version ) -ge 7 ]] ; then
			ECVS_MODULE="vim7"
		else
			ECVS_MODULE="vim"
		fi
		ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"
		cvs_src_unpack

	else
		# Apply any patches available from vim.org for this version
		[[ -n "$VIM_ORG_PATCHES" ]] && apply_vim_patches

		# Unpack the runtime snapshot if available (only for vim-core)
		if [[ -n "$VIM_RUNTIME_SNAP" ]] ; then
			cd ${S} || die
			ebegin "Unpacking vim runtime snapshot"
			rm -rf runtime
			# Changed this from bzip2 |tar to tar -j since the former broke for
			# some reason on freebsd.
			#  --spb, 2004/12/18
			tar xjf ${DISTDIR}/${VIM_RUNTIME_SNAP} 
			assert  # this will check both parts of the pipeline; eend would not
			eend 0
		fi
	fi

	# Another set of patches borrowed from src rpm to fix syntax errors etc.
	cd ${S} || die "cd ${S} failed"
	EPATCH_SUFFIX="gz" EPATCH_FORCE="yes" \
		epatch ${WORKDIR}/gentoo/patches-all/

	# Fixup a script to use awk instead of nawk
	sed -i '1s|.*|#!/usr/bin/awk -f|' ${S}/runtime/tools/mve.awk \
		|| die "mve.awk sed failed"

	# Patch to build with ruby-1.8.0_pre5 and following
	sed -i 's/defout/stdout/g' ${S}/src/if_ruby.c

	# Read vimrc and gvimrc from /etc/vim
	echo '#define SYS_VIMRC_FILE "/etc/vim/vimrc"' >> ${S}/src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/vim/gvimrc"' >> ${S}/src/feature.h

	# Use exuberant ctags which installs as /usr/bin/exuberant-ctags.
	# Hopefully this pattern won't break for a while at least.
	# This fixes bug 29398 (27 Sep 2003 agriffis)
	sed -i 's/\<ctags\("\| [-*.]\)/exuberant-&/g' \
		${S}/runtime/doc/syntax.txt \
		${S}/runtime/doc/tagsrch.txt \
		${S}/runtime/doc/usr_29.txt \
		${S}/runtime/menu.vim \
		${S}/src/configure.in || die 'sed failed'

	# Don't be fooled by /usr/include/libc.h.  When found, vim thinks
	# this is NeXT, but it's actually just a file in dev-libs/9libs
	# This fixes bug 43885 (20 Mar 2004 agriffis)
	sed -i 's/ libc\.h / /' ${S}/src/configure.in || die 'sed failed'

	# gcc on sparc32 has this, uhm, interesting problem with detecting EOF
	# correctly. To avoid some really entertaining error messages about stuff
	# which isn't even in the source file being invalid, we'll do some trickery
	# to make the error never occur. bug 66162 (02 October 2004 ciaranm)
	find ${S} -name '*.c' | while read c ; do echo >> "$c" ; done

	# if we're vim-7 and USE vim-pager, make the manpager.sh script
	if [[ "${MY_PN}" == "vim" ]] && [[ $(get_major_version ) -ge 7 ]] \
			&& use vim-pager ; then
		cat <<END > ${S}/runtime/macros/manpager.sh
#!/bin/sh
tr '\\267' '.' | col -b | \\
		vim \\
			-c 'let no_plugin_maps = 1' \\
			-c 'set nolist nomod ft=man' \\
			-c 'let g:showmarks_enable=0' \\
			-c 'runtime! macros/less.vim' -
END
	fi

}

src_compile() {
	local myconf confrule

	# Fix bug 37354: Disallow -funroll-all-loops on amd64
	# Bug 57859 suggests that we want to do this for all archs
	filter-flags -funroll-all-loops

	# Fix bug 76331: -O3 causes problems, use -O2 instead. We'll do this for
	# everyone since previous flag filtering bugs have turned out to affect
	# multiple archs...
	replace-flags -O3 -O2

	# Fix bug 18245: Prevent "make" from the following chain:
	# (1) Notice configure.in is newer than auto/configure
	# (2) Rebuild auto/configure
	# (3) Notice auto/configure is newer than auto/config.mk
	# (4) Run ./configure (with wrong args) to remake auto/config.mk
	sed -i 's/ auto.config.mk:/:/' src/Makefile || die "Makefile sed failed"
	rm -f src/auto/configure
	# vim-6.2 changed the name of this rule from auto/configure to autoconf
	confrule=auto/configure
	grep -q ^autoconf: src/Makefile && confrule=autoconf
	# autoconf-2.13 needed for this package -- bug 35319
	# except it seems we actually need 2.5 now -- bug 53777
	WANT_AUTOCONF=2.5 \
		make -C src $confrule || die "make $confrule failed"

	# This should fix a sandbox violation (see bug 24447). The hvc
	# things are for ppc64, see bug 86433.
	for file in /dev/pty/s* /dev/console /dev/hvc/* /dev/hvc* ; do
		[[ -e ${file} ]] && addwrite $file
	done

	if [[ "${MY_PN}" == "vim-core" ]] ||
			( [[ "${MY_PN}" == "vim" ]] && use minimal ); then
		myconf="--with-features=tiny \
			--enable-gui=no \
			--without-x \
			--disable-perlinterp \
			--disable-pythoninterp \
			--disable-rubyinterp \
			--disable-gpm"

	else
		use debug && append-flags "-DDEBUG"

		myconf="--with-features=huge \
			--enable-multibyte"
		myconf="${myconf} `use_enable cscope`"
		myconf="${myconf} `use_enable gpm`"
		myconf="${myconf} `use_enable perl perlinterp`"
		myconf="${myconf} `use_enable python pythoninterp`"
		myconf="${myconf} `use_enable ruby rubyinterp`"
		# tclinterp is broken; when you --enable-tclinterp flag, then
		# the following command never returns:
		#   VIMINIT='let OS=system("uname -s")' vim
		# vim7 seems to be ok though. (24 Sep 2004 ciaranm)
		if [[ $(get_major_version ) -ge 7 ]] ; then
			myconf="${myconf} `use_enable tcltk tclinterp`"
			myconf="${myconf} `use_enable mzscheme mzschemeinterp`"
			if [[ "${MY_PN}" == "gvim" ]] ; then
				myconf="${myconf} `use_enable netbeans`"
			fi

			# spell checking is turned on when we have syntax.
			if ! use spell ; then
				sed -i -e '/# \+define FEAT_SPELL/d' src/feature.h || \
					die "couldn't disable spell"
			fi
		fi

		# --with-features=huge forces on cscope even if we --disable it. We need
		# to sed this out to avoid screwiness. (1 Sep 2004 ciaranm)
		if ! use cscope ; then
			sed -i -e '/# define FEAT_CSCOPE/d' src/feature.h || \
				die "couldn't disable cscope"
		fi

		if [[ "${MY_PN}" == "vim" ]] ; then
			# don't test USE=X here ... see bug #19115
			# but need to provide a way to link against X ... see bug #20093
			myconf="${myconf} --enable-gui=no `use_with vim-with-x x`"

		elif [[ "${MY_PN}" == "gvim" ]] ; then
			myconf="${myconf} --with-vim-name=gvim --with-x"

			echo ; echo
			if [[ $(get_major_version ) -ge 7 ]] && use aqua ; then
				einfo "Building gvim with the Carbon GUI"
				myconf="${myconf} --enable-gui=carbon"
			elif use gtk ; then
				if use gtk2 ; then
					myconf="${myconf} --enable-gtk2-check"
					if use gnome ; then
						einfo "Building gvim with the Gnome 2 GUI"
						myconf="${myconf} --enable-gui=gnome2"
					else
						einfo "Building gvim with the gtk+-2 GUI"
						myconf="${myconf} --enable-gui=gtk2"
					fi
				else
					if use gnome ; then
						einfo "Building gvim with the Gnome 1 GUI"
						myconf="${myconf} --enable-gui=gnome"
					else
						einfo "Building gvim with the gtk+-1.2 GUI"
						myconf="${myconf} --enable-gui=gtk"
					fi
				fi
			elif [[ $(get_major_version ) -ge 7 ]] && use qt ; then
				einfo "Building gvim with the Qt GUI"
				myconf="${myconf} --enable-gui=kde --enable-kde-toolbar"
			elif use motif ; then
				einfo "Building gvim with the MOTIF GUI"
				myconf="${myconf} --enable-gui=motif"
			elif [[ $(get_major_version ) -ge 7 ]] && use nextaw ; then
				einfo "Building gvim with the neXtaw GUI"
				myconf="${myconf} --enable-gui=nextaw"
			else
				einfo "Building gvim with the Athena GUI"
				myconf="${myconf} --enable-gui=athena"
			fi
			echo ; echo

		else
			die "vim.eclass doesn't understand MY_PN=${MY_PN}"
		fi
	fi

	if [[ "${MY_PN}" == "vim" ]] && use minimal ; then
		myconf="${myconf} --disable-nls --disable-multibyte --disable-acl"
	else
		myconf="${myconf} `use_enable nls` `use_enable acl`"
	fi

	# Note: If USE=gpm, then ncurses will still be required
	use ncurses \
		&& myconf="${myconf} --with-tlib=ncurses" \
		|| myconf="${myconf} --with-tlib=termcap"

	use selinux \
		|| myconf="${myconf} --disable-selinux"

	econf ${myconf} || die "vim configure failed"

	# The following allows emake to be used
	make -C src auto/osdef.h objects || die "make failed"

	if [[ "${MY_PN}" == "vim-core" ]] ; then
		emake tools || die "emake tools failed"
		rm -f src/vim
	else
		emake || die "emake failed"
	fi

	[[ $(get_major_version ) -ge 7 ]] && [[ -f src/kvim ]] && mv src/{k,g}vim
}

src_install() {
	if [[ "${MY_PN}" == "vim-core" ]] ; then
		dodir /usr/{bin,share/{man/man1,vim}}
		cd src || die "cd src failed"
		if [[ $(get_major_version ) -ge 7 ]] ; then
			make \
				installruntime \
				installmanlinks \
				installmacros \
				installtutor \
				installtools \
				install-languages \
				install-icons \
				DESTDIR=${D} \
				BINDIR=/usr/bin \
				MANDIR=/usr/share/man \
				DATADIR=/usr/share \
				|| die "install failed"
		else
			make \
				installruntime \
				installhelplinks \
				installmacros \
				installtutor \
				installtools \
				install-languages \
				install-icons \
				DESTDIR=${D} \
				BINDIR=/usr/bin \
				MANDIR=/usr/share/man \
				DATADIR=/usr/share \
				|| die "install failed"
		fi

		keepdir /usr/share/vim/vim${VIM_VERSION/.}/keymap

		# Azarah put in the below "fix" in early 2002 but it makes
		# things painful when going from 6.1->6.2a, etc.  It also
		# seems to be completely unnecessary, so I'm removing it.
		# (24 Apr 2003 agriffis)
		#
		# fix problems with vim not finding its data files.
		#echo "VIMRUNTIME=/usr/share/vim/vim${VIM_VERSION/.}" > 40vim
		#insinto /etc/env.d
		#doins 40vim

		# default vimrc is installed by vim-core since it applies to
		# both vim and gvim
		insinto /etc/vim/
		newins ${FILESDIR}/vimrc${VIMRC_FILE_SUFFIX} vimrc

		if use livecd ; then
			# To save space, install only a subset of the files if we're on a
			# livecd. bug 65144.
			einfo "Removing some files for a smaller livecd install ..."

			local vimfiles=${D}/usr/share/vim/vim${VIM_VERSION/.}
			shopt -s extglob
			rm -fr ${vimfiles}/{compiler,doc,ftplugin,indent}
			rm -fr ${vimfiles}/{macros,print,tools,tutor}
			rm ${D}/usr/bin/vimtutor

			local keep_colors="default"
			ignore=$(rm -fr ${vimfiles}/colors/!(${keep_colors}).vim )

			local keep_syntax="conf|crontab|fstab|inittab|resolv|sshdconfig"
			# tinkering with the next line might make bad things happen ...
			keep_syntax="${keep_syntax}|syntax|nosyntax|synload"
			ignore=$(rm -fr ${vimfiles}/syntax/!(${keep_syntax}).vim )
		fi

		# These files might have slight security issues, so we won't
		# install them. See bug #77841. We don't mind if these don't
		# exist.
		rm ${D}/usr/share/vim/vim${VIM_VERSION/.}/tools/{vimspell.sh,tcltags} \
			|| true

	elif [[ "${MY_PN}" == "gvim" ]] ; then
		dobin src/gvim
		dosym gvim /usr/bin/gvimdiff
		dosym gvim /usr/bin/evim
		dosym gvim /usr/bin/eview
		# bug #74349 says we should install these
		if version_is_at_least "6.3-r4" ; then
			dosym gvim /usr/bin/gview
			dosym gvim /usr/bin/rgvim
			dosym gvim /usr/bin/rgview
		fi
		insinto /etc/vim
		newins ${FILESDIR}/gvimrc${GVIMRC_FILE_SUFFIX} gvimrc

		# as of 6.3-r1, we install a desktop entry. bug #44633, and bug #68622
		# for the nicer updated version.
		insinto /usr/share/applications
		doins ${FILESDIR}/gvim.desktop
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/gvim.xpm

	else
		dobin src/vim
		ln -s vim ${D}/usr/bin/vimdiff && \
		ln -s vim ${D}/usr/bin/rvim && \
		ln -s vim ${D}/usr/bin/ex && \
		ln -s vim ${D}/usr/bin/view && \
		ln -s vim ${D}/usr/bin/rview \
			|| die "/usr/bin symlinks failed"
		if [[ $(get_major_version ) -ge 7 ]] && use vim-pager ; then
			ln -s /usr/share/vim/vim${VIM_VERSION//./}/macros/less.sh \
					${D}/usr/bin/vimpager
			ln -s /usr/share/vim/vim${VIM_VERSION//./}/macros/manpager.sh \
					${D}/usr/bin/vimmanpager
			insinto /usr/share/vim/vim${VIM_VERSION//./}/macros
			doins runtime/macros/manpager.sh
			fperms a+x /usr/share/vim/vim${VIM_VERSION//./}/macros/manpager.sh
		fi
	fi

	# bash completion script, bug #79018.
	if [[ $(get_major_version ) -ge 7 ]] ; then
		if [[ "${MY_PN}" == "vim-core" ]] ; then
			dobashcompletion ${FILESDIR}/xxd-completion xxd
		else
			dobashcompletion ${FILESDIR}/${MY_PN}-completion ${MY_PN}
		fi
	fi

	if [[ $(get_major_version ) -ge 7 ]] ; then
		if ! use spell ; then
			rm -fr ${D}/usr/share/vim/vim${VIM_VERSION/.}/spell || true
		else
			if [[ "${MY_PN}" == "vim-core" ]] ; then
				insinto /usr/share/vim/vim${VIM_VERSION//./}/spell
				doins ${S}/runtime/spell/*.spl
			fi
		fi
	fi
}

# Make convenience symlinks, hopefully without stepping on toes.  Some
# of these links are "owned" by the vim ebuild when it is installed,
# but they might be good for gvim as well (see bug 45828)
update_vim_symlinks() {
	local f syms

	# Some of these are provided already on x86-fbsd, bug 69535.
	if use x86-fbsd ; then
		syms="vimdiff rvim rview"
	else
		syms="vi vimdiff rvim ex view rview"
	fi

	# Make or remove convenience symlink, vim -> gvim
	if [[ -f ${ROOT}/usr/bin/gvim ]]; then
		ln -s gvim ${ROOT}/usr/bin/vim 2>/dev/null
	elif [[ -L ${ROOT}/usr/bin/vim && ! -f ${ROOT}/usr/bin/vim ]]; then
		rm ${ROOT}/usr/bin/vim
	fi

	# Make or remove convenience symlinks to vim
	if [[ -f ${ROOT}/usr/bin/vim ]]; then
		for f in ${syms}; do
			ln -s vim ${ROOT}/usr/bin/${f} 2>/dev/null
		done
	else
		for f in ${syms}; do
			if [[ -L ${ROOT}/usr/bin/${f} && ! -f ${ROOT}/usr/bin/${f} ]]; then
				rm -f ${ROOT}/usr/bin/${f}
			fi
		done
	fi

	# This will still break if you merge then remove the vi package,
	# but there's only so much you can do, eh?  Unfortunately we don't
	# have triggers like are done in rpm-land.
}

pkg_postinst() {
	# Update documentation tags (from vim-doc.eclass)
	update_vim_helptags

	# Update fdo mime stuff, bug #78394
	if [[ "${MY_PN}" == "gvim" ]] ; then
		fdo-mime_mime_database_update
	fi

	einfo
	if [[ $(get_major_version ) -lt 7 ]] ; then
		if [[ "${MY_PN}" == "gvim" ]] ; then
			einfo "To enable UTF-8 viewing, set guifont and guifontwide: "
			einfo ":set guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1"
			einfo ":set guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1"
			einfo
			einfo "note: to find out which fonts you can use, please read the UTF-8 help:"
			einfo ":h utf-8"
			einfo
			einfo "Then, set read encoding to UTF-8:"
			einfo ":set encoding=utf-8"
		elif [[ "${MY_PN}" == "vim" ]] ; then
			einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
		fi
	else
		if [[ "${MY_PN}" == "gvim" ]] ; then
			echo
			# TODO: once we have all the GUIs working, display a message
			# explaining them.
		elif [[ "${MY_PN}" == "vim" ]] ; then
			echo
			# TODO: once we have the GUIs working, display a message explaining
			# them.
		fi

		if use spell ; then
			einfo "You have enabled spell checking support. This is rather, uh,"
			einfo "experimental at the moment. To enable it, use the following"
			einfo "command:"
			einfo "    :setlocal spell spelllang=en"
			einfo "Currently only en, en_us and en_uk are available."
		fi
	fi
	einfo

	if [[ "${MY_PN}" != "vim-core" ]] ; then
		einfo "To see what's new in this release, use :help version${VIM_VERSION/.*}.txt"
		einfo
	fi

	# Warn about VIMRUNTIME
	if [ -n "$VIMRUNTIME" -a "${VIMRUNTIME##*/vim}" != "${VIM_VERSION/.}" ] ; then
		ewarn
		ewarn "WARNING: You have VIMRUNTIME set in your environment from an old"
		ewarn "installation.  You will need to either unset VIMRUNTIME in each"
		ewarn "terminal, or log out completely and back in.  This problem won't"
		ewarn "happen again since the ebuild no longer sets VIMRUNTIME."
		ewarn
	fi

	# Scream loudly if the user is using a -cvs ebuild
	if [[ -z "${PN/*-cvs}" ]] ; then
		ewarn "You are using a -cvs ebuild. Be warned that this is not"
		ewarn "officially supported and may not work."
		ewarn " "
		ebeep 5
	fi

	if [[ $(get_major_version ) -ge 7 ]] ; then
		bash-completion_pkg_postinst
	fi

	# Make convenience symlinks
	update_vim_symlinks
}

pkg_postrm() {
	# Update documentation tags (from vim-doc.eclass)
	update_vim_helptags

	# Make convenience symlinks
	update_vim_symlinks

	# Update fdo mime stuff, bug #78394
	if [[ "${MY_PN}" == "gvim" ]] ; then
		fdo-mime_mime_database_update
	fi
}

src_test() {

	if [[ "${MY_PN}" == "vim-core" ]] ; then
		einfo "No testing needs to be done for vim-core"
		return
	fi

	einfo " "
	einfo "Starting vim tests. Several error messages will be shown "
	einfo "whilst the tests run. This is normal behaviour and does not "
	einfo "indicate a fault."
	einfo " "
	ewarn "If the tests fail, your terminal may be left in a strange "
	ewarn "state. Usually, running 'reset' will fix this."
	ewarn " "
	echo

	# Don't let vim talk to X
	unset DISPLAY

	if [[ "${MY_PN}" == "gvim" ]] ; then
		# Make gvim not try to connect to X. See :help gui-x11-start
		# in vim for how this evil trickery works.
		ln -s ${S}/src/gvim ${S}/src/testvim
		testprog="../testvim"
	else
		testprog="../vim"
	fi

	# We've got to call make test from within testdir, since the Makefiles
	# don't pass through our VIMPROG argument
	cd ${S}/src/testdir

	# Test 49 won't work inside a portage environment
	einfo "Test 49 isn't sandbox-friendly, so it will be skipped."
	sed -i -e 's~test49.out~~g' Makefile

	# TODO: Find out why this test doesn't work with vim7. Hopefully it'll get
	# fixed fairly soon. Not worth tracking it down until the hashtables code
	# stabilises though.. (22 Jan 2005 ciaranm)
	if version_is_at_least "7.0_alpha20050201" ; then
		einfo "Test 55, which checks various new vim7 features, is believed"
		einfo "to be working again. If it fails with a segfault, please"
		einfo "let ciaranm know by email or on IRC."

	elif version_is_at_least "7.0_alpha20050122" ; then
		einfo "Test 55 shows some known bugs in new vim7 features. It will"
		einfo "fail with a segfault, so it will be skipped for now."
		sed -i -e 's~test55.out~~g' Makefile
	fi

	# We don't want to rebuild vim before running the tests
	sed -i -e 's,: \$(VIMPROG),: ,' Makefile

	# Give the user time to read the "what to do if these break" messages
	epause 10

	# Don't try to do the additional GUI test
	make VIMPROG=${testprog} nongui \
		|| die "At least one test failed"
}

