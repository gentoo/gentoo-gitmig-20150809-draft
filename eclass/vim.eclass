# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vim.eclass,v 1.25 2003/04/29 00:11:50 agriffis Exp $

# Authors:
# 	Ryan Phillips <rphillips@gentoo.org>
# 	Seemant Kulleen <seemant@gentoo.org>
# 	Aron Griffis <agriffis@gentoo.org>

ECLASS=vim
EXPORT_FUNCTIONS src_unpack

inherit eutils

IUSE="gnome gpm gtk gtk2 ncurses nls perl python ruby vim-with-x X"

HOMEPAGE="http://www.vim.org/"
SLOT="0"
LICENSE="vim"

# portage dependency is for use_with/use_enable
DEPEND="
	>=sys-apps/portage-2.0.45-r3
	>=sys-apps/sed-4
	sys-devel/autoconf
	dev-util/cscope
	vim-with-x? ( x11-base/xfree )
	gpm?     ( >=sys-libs/gpm-1.19.3 )
	ncurses? ( >=sys-libs/ncurses-5.2-r2 ) : ( sys-libs/libtermcap-compat )
	perl?    ( dev-lang/perl )
	python?  ( dev-lang/python )
	ruby?    ( =dev-lang/ruby-1.6* )"  # ruby-1.8 doesn't work yet with vim

apply_vim_patches() {
	local p
	cd ${S}

	# Scan the patches, applying them only to files that either
	# already exist or that will be created by the patch
	einfo "Filtering vim patches..."
	p=${WORKDIR}/${VIM_ORG_PATCHES%.tar*}.patch
	ls ${WORKDIR}/vimpatches | sort | \
	xargs -i gzip -dc ${WORKDIR}/vimpatches/{} | awk '
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
	ebegin "Applying filtered vim patches..."
	TMPDIR=${T} patch -f -s -p0 < ${p}
	eend 0
}

vim_src_unpack() {
	unpack ${A}

	# Apply any patches available from vim.org for this version
	[ -n "$VIM_ORG_PATCHES" ] && apply_vim_patches

	# Another set of patch's borrowed from src rpm to fix syntax error's etc.
	cd ${S}
	EPATCH_SUFFIX="gz" \
		EPATCH_FORCE="yes" \
		epatch ${WORKDIR}/gentoo/patches-all/

	# Fixup a script to use awk instead of nawk
	sed -i '1s|.*|#!/usr/bin/awk -f|' ${S}/runtime/tools/mve.awk
	assert "Error fixing mve.awk"

	# Read vimrc and gvimrc from /etc/vim
	echo '#define SYS_VIMRC_FILE "/etc/vim/vimrc"' >> src/feature.h
	echo '#define SYS_GVIMRC_FILE "/etc/vim/gvimrc"' >> src/feature.h
}

src_compile() {
	local myconf

	# Fix bug #18245: Prevent "make" from the following chain:
	# (1) Notice configure.in is newer than auto/configure
	# (2) Rebuild auto/configure
	# (3) Notice auto/configure is newer than auto/config.mk
	# (4) Run ./configure (with wrong args) to remake auto/config.mk
	sed -i 's/ auto.config.mk:/:/' src/Makefile
	rm -f src/auto/configure
	make -C src auto/configure || die "make auto/configure failed"

	# This should fix a sandbox violation.
	for file in /dev/pty/s*; do
		addwrite $file
	done

	if [ ${PN} = vim-core ]; then
		myconf="--with-features=tiny \
			--enable-gui=no \
			--without-x \
			--disable-perlinterp \
			--disable-pythoninterp \
			--disable-rubyinterp \
			--disable-gpm"
	else
		myconf="--with-features=huge \
			--enable-cscope \
			--enable-multibyte"
		myconf="${myconf} `use_enable gpm`"
		myconf="${myconf} `use_enable perl perlinterp`"
		myconf="${myconf} `use_enable python pythoninterp`"
		myconf="${myconf} `use_enable ruby rubyinterp`"
		# tclinterp is broken; when you --enable-tclinterp flag, then
		# the following command never returns:
		#   VIMINIT='let OS=system("uname -s")' vim
		#myconf="${myconf} `use_enable tcl tclinterp`"

		if [ ${PN} = vim ]; then
			# don't test USE=X here... see bug #19115
			# but need to provide a way to link against X... see bug #20093
			myconf="${myconf} --enable-gui=no `use_with vim-with-x x`"
		elif [ ${PN} = gvim ]; then
			myconf="${myconf} --with-vim-name=gvim --with-x"
			if use gtk2; then
				myconf="${myconf} --enable-gui=gtk2 --enable-gtk2-check"
			elif use gnome; then
				myconf="${myconf} --enable-gui=gnome"
			elif use gtk; then
				myconf="${myconf} --enable-gui=gtk"
			elif use motif; then
				myconf="${myconf} --enable-gui=motif"
			else
				myconf="${myconf} --enable-gui=athena"
			fi
		else
			die "vim.eclass doesn't understand PN=${PN}"
		fi
	fi

	myconf="${myconf} `use_enable nls`"

	# Note: If USE=gpm, then ncurses will still be required
	use ncurses \
		&& myconf="${myconf} --with-tlib=ncurses" \
		|| myconf="${myconf} --with-tlib=termcap"

	econf ${myconf} || die "vim configure failed"

	# The following allows emake to be used
	make -C src auto/osdef.h objects || die "make failed"

	if [ "${PN}" = "vim-core" ]; then
		emake tools || die "emake tools failed"
		rm -f src/vim
	else
		emake || die "emake failed"
	fi
}

src_install() {
	if [ "${PN}" = "vim-core" ]; then
		dodir /usr/{bin,share/{man/man1,vim}}
		cd src
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

		dodoc README*
		cd $D/usr/share/doc/$PF
		ln -s ../../vim/*/doc $P

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
		doins ${FILESDIR}/vimrc
	elif [ "${PN}" = "gvim" ]; then
		dobin src/gvim
		dosym gvim /usr/bin/gvimdiff
		insinto /etc/vim
		doins ${FILESDIR}/gvimrc
	else
		dobin src/vim
		ln -s vim ${D}/usr/bin/vimdiff
		ln -s vim ${D}/usr/bin/rvim
		ln -s vim  ${D}/usr/bin/ex
		ln -s vim  ${D}/usr/bin/view
		ln -s vim  ${D}/usr/bin/rview
	fi
}

pkg_postinst() {
	einfo
	if [ ${PN} = gvim ]; then
		einfo "To enable UTF-8 viewing, set guifont and guifontwide: "
		einfo ":set guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1"
		einfo ":set guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1"
		einfo
		einfo "note: to find out which fonts you can use, please read the UTF-8 help:"
		einfo ":h utf-8"
		einfo
		einfo "Then, set read encoding to UTF-8:"
		einfo ":set encoding=utf-8"
	elif [ ${PN} = vim ]; then
		einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
	fi
	einfo

	# Make convenience symlinks, hopefully without stepping on toes
	[ -f /usr/bin/gvim ] && ln -s gvim /usr/bin/vim 2>/dev/null
	[ -f /usr/bin/vim ] && ln -s vim /usr/bin/vi 2>/dev/null
}
