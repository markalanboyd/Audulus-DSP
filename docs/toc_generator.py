import os

def generate_toc(root, dir_name):
    toc = []
    for dirpath, dirnames, _ in os.walk(os.path.join(root, dir_name)):
        level = dirpath.replace(root, '').count(os.sep)
        indent = '  ' * (level - 1)
        
        dirnames.sort()

        if level > 0:
            dirname = os.path.basename(dirpath)
            link = os.path.join('.', dirpath.replace(root, 'code'))
            toc.append(f"{indent}- [`{dirname}`]({link})\n")

    return ''.join(toc[1:])

def main():
    root_dir = './code'
    output_file = 'table_of_contents.md'

    toc = generate_toc(root_dir, '')

    with open(output_file, 'w') as f:
        f.write(toc)

    print(f"Table of contents generated and saved to {output_file}")

if __name__ == "__main__":
    main()
